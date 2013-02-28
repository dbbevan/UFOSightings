#Pandas related imports here
import numpy
import pandas
import matplotlib.pyplot as plt
import random
import datetime

import scipy.signal
import pylab

#Custom imports here
import json
#JSON data loading
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
##
sighting_duration_list = []
df_select_out_sighting_dates_appear = None
# create the index from the dates times list
ts_select_out_sighting_dates_index_appear = pandas.Index(df_select_out_sighting_dates_appear)
plt.xlabel('Year of sightings')
plt.ylabel('Appear time(per second)')
plt.plot_date(pylab.date2num( ts_select_out_sighting_dates_index_appear ), sighting_duration_list, linestyle='-',color='b')