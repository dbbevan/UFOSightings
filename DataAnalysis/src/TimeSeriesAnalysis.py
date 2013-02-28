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
##Variables
sighting_item_columns = ["duration","shape","location","sighted_at","description","reported_at"]
sighting_duration_list = []
###DataFrame
df_select_out_sighted_at = None
###TimeSeries
ts_select_out_sighted_at = None
# assemble the data frame,
# reference on <<Python_for_data_analysis>>,chapter 06-DataLoading,Storage,and File Formats
df_select_out_sighted_at = pandas.DataFrame(json_data_results,columns=sighting_item_columns)
print("DataFrame:",df_select_out_sighted_at)
# create the index from the dates times list
ts_select_out_sighted_at = pandas.Index(df_select_out_sighted_at)
plt.xlabel('Year of sightings')
plt.ylabel('Appear time(per second)')
plt.plot_date(pylab.date2num( ts_select_out_sighted_at ), sighting_duration_list, linestyle='-',color='b')