import json
#print( json.dumps(['foo', {'bar': ('baz', None, 1.0, 2)}]) )

JSON_FILE_PATH = '../datasets/AllSightings.json'
#Load json file to string
json_raw_data = open(JSON_FILE_PATH)
json_data = json.load(json_raw_data)
##print
print(json_data)
#Read string
for key, value in json_data.iteritems():
    print key,value