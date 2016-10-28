clear all;
close all;

name = input(' Enter your name\n ','s');
%disp(name)
recorder = audiorecorder;
recordblocking(recorder,5);
name = strcat(name,'.wav');
y = getaudiodata(recorder);
audiowrite(name,y,8000)