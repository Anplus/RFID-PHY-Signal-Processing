clc;clear;close all;
dbstop if error;
%% file
fid = fopen('../../data/move/20180928221314_2ch.bin','rb');
[B2,Count] = fread(fid,[4,6000000],'double');
fclose(fid);

%% data
array = B2(1,:)+1i*B2(2,:);
single = B2(3,:)+1i*B2(4,:); 
single_abs = abs(single);
figure;
plot(single_abs);
figure;
plot(abs(array));

%% sniffer
% slow : query 
sample_rate = 6e6;
samples_per_us = sample_rate/1e6;
preamble_send = gen_baseband_slow_preamble-0.5;
figure;
plot(preamble_send);
% corr
[acor,lag] = xcorr(preamble_send,single_abs(1:3*length(preamble_send)));
[~,I] = max(abs(acor));
lagDiff = abs(lag(I));
figure;
plot(acor);
% tag
start = lagDiff+length(gen_baseband_slow_preamble);
tag_preamble = [];





