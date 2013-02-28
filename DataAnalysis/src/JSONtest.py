import json
#print( json.dumps(['foo', {'bar': ('baz', None, 1.0, 2)}]) )

JSON_FILE_PATH = '../datasets/AllSightings.json'
#Load json file to string,decode
json_raw_data = open(JSON_FILE_PATH)
json_data = json.load(json_raw_data)
##print
print(json_data)
#Read string
for key, value in json_data.iteritems():
    print key,value
##
json_data_results = json_data['results']
print('results:',json_data_results)
print('results len:',len(json_data_results))
print(json_data_results[0])
print(json_data_results[0]["description"])
print(json_data_results[0]["sighted_at"])
print(json_data_results[0]["reported_at"])
print(json_data_results[0]["duration"])
print(json_data_results[0]["location"])
print(json_data_results[0]["shape"])
