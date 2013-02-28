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
#for key, value in json_data.iteritems():
#    print key,value
##
json_data_results = json_data['results']
print('json_data_results:',json_data_results)
#print('results len:',len(json_data_results))
#print(json_data_results[0])
#print(json_data_results[0]["description"])
#print(json_data_results[0]["sighted_at"])
#print(json_data_results[0]["reported_at"])
#print(json_data_results[0]["duration"])
#print(json_data_results[0]["location"])
#print(json_data_results[0]["shape"])
##Variables
sighting_item_columns = ["duration","shape","location","sighted_at","description","reported_at"]
sighting_duration_list = []
len_json_data_results = len(json_data_results)
for x in range(0,len_json_data_results-1):
#    print(json_data_results[x]["duration"])
    if "duration" in json_data_results[x] :
        ##none-uniformed string parse to date time
        sighting_duration_list.append(json_data_results[x]["duration"])
    else:
        sighting_duration_list.append("1sec")#Default 1sec, for none date time handler.
print("sighting_duration_list:",sighting_duration_list) 
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
print("TimeSeries:",ts_select_out_sighted_at);
plt.xlabel('Year of sightings')
plt.ylabel('Appear time(per second)')
##A time-series plot:trend and seasonal-lity:
ts_date_range = pandas.date_range('1/1/2000',periods=20)
print(ts_date_range)
ts_example = pandas.TimeSeries(numpy.random.randn(20),index=ts_date_range)
#ts_example.cumsum()
ts_example.plot()
plt.plot(ts_example)
#plt.xlabel(ts_date_range)
plt.show()
#plt.plot_date(pylab.date2num( ts_select_out_sighted_at ), sighting_duration_list, linestyle='-',color='b')
plt.plot_date(pylab.date2num( pandas.date_range('1/1/2000', periods=len_json_data_results) ), sighting_duration_list, linestyle='-',color='b')