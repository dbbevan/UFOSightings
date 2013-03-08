#Pandas related imports here
import numpy
import pandas
import matplotlib.pyplot as plt
import random
import datetime

import scipy.signal
import pylab

#Custom imports here
import re #RegressExpression
import json
#JSON data loading
#print( json.dumps(['foo', {'bar': ('baz', None, 1.0, 2)}]) )
#JSON_FILE_PATH = '../datasets/AllSightings.json'
JSON_FILE_PATH = '../datasets/ufo_awesome_5943.json'
#http://en.wikipedia.org/wiki/Roswell_UFO_Incident, NAN value will return the time stamp of RoseWell :-)
HARD_CODE_DATE_TIME = "1947-07-08"
#Load json file to string,decode
json_raw_data = open(JSON_FILE_PATH)
json_data = json.load(json_raw_data)
##print
print(json_data)
#Utilities
#String to date time
##ymd
def ymd_convert(value):
    '''
    Convert dates in the imported UFO data.
    Clean entries will look like YYYMMDD. If they're not clean, return NA.
    '''
    if value=='0000': return HARD_CODE_DATE_TIME
    try:
        cnv_dt = datetime.datetime.strptime(str(value), '%Y%m%d')
    except ValueError:
        cnv_dt = HARD_CODE_DATE_TIME
    
    return cnv_dt.date()
##GuassianSmoothing
def applyGuassianSmoothing(data):
        # Finding a smoothed version of the time series:
        # 1) Construct a 31-point Gaussian filter with standard deviation = 4
        filt = scipy.signal.gaussian( 31, 4 )
        # 2) Normalize the filter through dividing by the sum of its elements
        filt /= sum( filt )
        # 3) Pad data on both sides with half the filter length of the last value
        #    (The function ones(k) returns a vector of length k, with all elements 1.)
        n = len(data)
        padded = numpy.ma.concatenate( (data[0]*numpy.ones(31//2), data, data[n-1]*numpy.ones(31//2)) )
        # 4) Convolve the data with the filter. See text for the meaning of "mode".
        smooth = scipy.signal.convolve( padded, filt, mode='valid' )
        
        return smooth
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
df_select_out_sighted_at = None#DataFrame
len_json_data_results = len(json_data_results)
for x in range(0,len_json_data_results):
#    print(json_data_results[x]["duration"])
#    time_period = random.randint(0,len_json_data_results) 
    num_time_period = 1
    if "duration" in json_data_results[x] :
        ##none-uniformed string parse to date time
        time_period = json_data_results[x]["duration"]
        time_period = time_period.lower()#lower string
        ##@see http://www.devshed.com/c/a/Python/String-Manipulation/3/
        ##Python string operation,keywords:year,month,day,hour,min,sec
#        if re.search('(year)',time_period) :
#            num_time_period += 30*24*60*60
#        if re.search('(month)',time_period) :
#            num_time_period += 10*24*60*60
#        if re.search('(day)',time_period) :
#            num_time_period += 1*24*60*60
#        if re.search('(hour)',time_period) :
#            num_time_period += 1*60*60
        if re.search('(min)',time_period) :
            num_time_period += 1*60
        if re.search('(sec)',time_period) :
            num_time_period += 1*10   
                             
#        print("num_time_period:",num_time_period)
#        time_period = time_period.trip()#trim
#        time_period = time_period.ltrip()#l-trim
#        time_period = time_period.rtrip()#r-trim
        sighting_duration_list.append(num_time_period)
    else:
        sighting_duration_list.append(num_time_period)#Default 1sec, for none date time handler.
print("sighting_duration_list:",sighting_duration_list) 
###DataFrame
df_select_out_sighted_at = None
###TimeSeries
ts_select_out_sighted_at = None
# assemble the data frame,
# reference on <<Python_for_data_analysis>>,chapter 06-DataLoading,Storage,and File Formats
df_select_out_all = pandas.DataFrame(json_data_results,columns=sighting_item_columns)
print("DataFrame all:",df_select_out_all)
df_select_out_sighted_at = df_select_out_all['sighted_at'].map(ymd_convert)
print("DataFrame sight_at:",df_select_out_sighted_at)
# create the index from the dates times list
ts_select_out_sighted_at = pandas.Index(df_select_out_sighted_at)
print("TimeSeries:",ts_select_out_sighted_at);
plt.xlabel('Year of sightings')
plt.ylabel('Appear time(per second)')
##A time-series plot:trend and seasonal-lity:
#ts_date_range = pandas.date_range('1/1/2000',periods=len_json_data_results)
#print(ts_date_range)
#ts_example = pandas.TimeSeries(numpy.random.randn(len_json_data_results),index=ts_date_range)
#ts_example.cumsum()
#ts_example.plot()
#plt.plot(ts_example)
#plt.xlabel(ts_date_range)
#plt.show()
#plt.plot_date(pylab.date2num( pandas.date_range('1/1/2000', periods=len_json_data_results-1) ), sighting_duration_list, linestyle='-',color='b')
plt.plot_date(ts_select_out_sighted_at , sighting_duration_list, linestyle='-',color='b')
#plt.plot_date(pylab.date2num( pandas.date_range('1/1/2000', periods=len_json_data_results) ), sighting_duration_list, linestyle='-',color='b')
##Apply Guassian Smoothing
sighting_duration_list = applyGuassianSmoothing(sighting_duration_list)
plt.plot_date(ts_select_out_sighted_at , sighting_duration_list, linestyle='-',color='g')
##Plot show
plt.show()

