import sys, os
sys.path.append(os.environ['ANTELOPE'] + "/data/python")

import antelope.datascope as ds
import csv
import datetime as dt
import argparse as arg

def configure():
    parser = arg.ArgumentParser()
    parser.add_argument("-maxlat")
    parser.add_argument("-minlat")
    parser.add_argument("-maxlon")
    parser.add_argument("-minlon")
    args = parser.parse_args()
    return args

def main():
    args = configure()
    field_names = ["mag", "lat", "lon", "depth", "time"]
    historics = []
    current_year = int("{:04}".format(dt.datetime.now().year))
    years = range(1988, current_year)

    # Get historic data
    #print("Getting historic data from /aec/db/catalogs/final/Total")
    #historics = get_vals("/aec/db/catalogs/final/Total", field_names, historics)

    # Get recent data that's been put into the yearly catalogs
    for year in years:
        print(f"Getting data from yearly catalogs\nCurrent catalog:\t/aec/db/catalogs/final/yearly/catalog_{year}")
        historics = get_vals(f"/aec/db/catalogs/final/yearly/catalog_{year}", field_names, historics, args)
    
    # Get summary database
    print("Getting recent data from /aec/db/catalogs/summary/summary")
    historics = get_vals("/aec/db/catalogs/summary/summary", field_names, historics, args)

    with open('historics.csv', 'w') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames = field_names)
        writer.writeheader()
        writer.writerows(historics)
    return

def get_vals(dbname, field_names, historics, args):
    db = ds.dbopen(dbname, "r")

    dborigin = db.lookup(table = "origin")
    dbjoined = dborigin.join("netmag")

    # Subset
    dbsub = dbjoined.subset(f'lat>={args.minlat} && lat<={args.maxlat} && lon>={args.minlon} && lon<={args.maxlon}')

    print(f'Number of records matching search criteria:\t{dbsub.record_count}')

    for ev in dbsub.iter_record():

        historics.append({
            field_names[0] : ev.getv("netmag.magnitude")[0],
            field_names[1] : ev.getv("lat")[0],
            field_names[2] : ev.getv("lon")[0],
            field_names[3] : ev.getv("depth")[0],
            field_names[4] : ev.getv("time")[0]
            })
    return historics

if __name__ == "__main__":
    status = main()
    sys.exit(status)