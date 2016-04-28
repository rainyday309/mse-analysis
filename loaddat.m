function [Voltage, Fs, Label, PhysDim]=loaddat(FILENAME,CHAN)
% signal=loaddat(FILENAME)
% Loads EEG data which is stored according to the following file format
% DAT Brain Atlas EEG Data File Structure BLSC GMP #820.181-5.2 REVISION: 12/21/90 
%     Filenames: E*.DAT 
%     Defined by: BIOLOGIC SYSTEMS CORPORATION 

%	Version 0.35
%	27.06.2002
%	Copyright (c) 1998-2002 by  Alois Schloegl <a.schloegl@ieee.org>	

% This program is free software; you can redistribute it and/or
% modify it under the terms of the GNU General Public License
% as published by the Free Software Foundation; either version 2
% of the  License, or (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.


global SAMPLE_RATE;
SAMPLE_RATE=128;
Fs=128;
PhysDim='µV';

if find(FILENAME=='.')==[] FILENAME=[FILENAME '.dat']; end;

BYTE='uint8';
WORD='int16';
ULONG='int32'; 
DOUBLE='float32';

fid=fopen(FILENAME,'r','ieee-le');
if fid<0
	fprintf(2,['Error LOADDAT: File ' FILENAME ' not found\n']);  
	return;
end;

%VARIABLE	TYPE			#bytes	OFFSET	COMMENT
BpDP=fread(fid,1,BYTE);		%	1 Byte		Bytes per Data Point
NoBlks=fread(fid,1,BYTE);	%	1 Byte	
BAVer=fread(fid,1,WORD)/100;	%	2 Byte	
ADsize=fread(fid,1,BYTE);	%	1 Byte	
AmpType=fread(fid,1,BYTE);	%	1 Byte	
BAmnu=fread(fid,1,WORD);	%	2 Byte	
BAsub=fread(fid,1,BYTE);	%	1 Byte	
	tmp=fread(fid,15+10+25+25+20+2+20+11+10+25+25+70+40,BYTE);		%	1 Byte	

FileName=fread(fid,8,'char');	%
if FileName(1)~='E' fprintf(2,'LOADDAT: WARNING FilePrefix isn''t ''E''');end;
	unused=fread(fid,7+3,BYTE);	%
LF=fread(fid,5,'char');	%
HF=fread(fid,5,'char');	%
RefPos=fread(fid,6,'char');	%
GndPos=fread(fid,5,'char');	%

NoChan=fread(fid,1,BYTE);	%
NormFlag=fread(fid,1,BYTE);	%
	tmp=fread(fid,4,BYTE);	%
ReCount=fread(fid,1,WORD);	% EEG record Count
nosets=fread(fid,1,WORD);	% Number of EEG sets
NoChSe=fread(fid,1,WORD);	% Number of Channels in an EEG set

	unused=fread(fid,9,BYTE);	%
	tmp=fread(fid,1+2+2+2+2+1,BYTE);	%
N_S_=fread(fid,8,WORD);	%
	tmp=fread(fid,2*8+1+2+1,BYTE);	%
DISCALE=fread(fid,1,BYTE);	% Display Scale 0..7 for display scale in power of 2
	tmp=fread(fid,1,BYTE);	%
EPOCH=fread(fid,1,WORD);	% Epoch in ms
	tmp=fread(fid,2+2+1+1,BYTE);	%
IDF=fread(fid,1,BYTE);		% Invert Data Flag
	unused=fread(fid,1,BYTE);		% 

CV=fread(fid,21,BYTE);	%
DC=fread(fid,21,BYTE);	%
SENS=fread(fid,1,WORD);	%
CALUV=fread(fid,1,WORD);	%
	UU2=fread(fid,1,BYTE);	%
	tmp=fread(fid,1+1+1+1+2+1+1+1+2+1+1+1+1+1+1+1+1+2+1+16+16+1+1+1+1+6+1+1+1+1+2+1+1+1+2+1,BYTE);	%
	tmp=fread(fid,1+1+1+1+1+1+1+2+1+16+16+1+1+1+1+6,BYTE);	%
	UU3=fread(fid,1,WORD);	%
GAIN=fread(fid,32,BYTE);	%
	UU4=fread(fid,2,BYTE);	%
LPFC=fread(fid,34,BYTE);	%
HPFC=fread(fid,34,BYTE);	%
NTFC=fread(fid,34,BYTE);	%
ADCV=fread(fid,34,BYTE);	%
	tmp=fread(fid,8+8+2+1+1+1+1+4*1+1,BYTE);	%
	UU5=fread(fid,1,BYTE);	%
CHAI=fread(fid,32,BYTE);	%	Channel Active/Inactive Flag Table
	tmp=fread(fid,2+1+2,BYTE);	%
ADsource=fread(fid,1,WORD);	%
AGV=fread(fid,1,'float32');	%	Actual Gain Value of the WORD "ALL" gain (?)
	tmp=fread(fid,1+4*10+1+2+8*2+1+120+160*4,BYTE);	%

if BAVer<2.34
	clear ELPOS;
else
	tmp=fread(fid,64+128+2+2,BYTE);	%
	ElPos=fread(fid,[6,21],'char');	%
end;
Label=char(ElPos(:,CHAN)');

fseek(fid,NoBlks*128,-1);
[ADV,count]=fread(fid,[NoChan inf],'uint8');
fclose(fid);
count=count/NoChan;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%codetab;	% Loading the Code Table
%load codetab
gain_code=[10 24;
           50 25;
           75 26;
           100 27;
           150 28;
           200 29;
           300 31;
           500 17;
           750 18;
           1000 19;
           1500 20;
           2000 21;
           2500 22;
           3000 23;
           5000 9;
           7500 10;
           10000 11;
           15000 12;
           20000 13;
           25000 14;
           30000 15;
           50000 1;
           75000 2;
           100000 3;
           150000 4;
           200000 5;
           250000 6;
           300000 7];
                     
lpf_code=[ 30 100 150 300 500 750 1000 70 300 1000 1500 3000 5000 7500 10000 700];                     
hpf_code=[.1 .3  1  3 10 30 100 300 inf];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    


for k=1:length(GAIN),                                      
	gain(k)=gain_code(find(gain_code(:,2)==GAIN(k)),1);                                      
end;
                                      
NS=1;
if  AmpType==0	%External Amplifier
	Voltage=(((ADV'/NS)-128)-(DC-128))*(2*CALUV/CV)*(SENS/10);
elseif AmpType==1	%Internal Amplifier
	Voltage=(((ADV'/NS)-128)-((DC-128)*gain/300000))*(200/CV)*(20000/gain)
elseif  AmpType>=2	%Internal Amplifier
	Voltage=zeros(count,NoChan);
	for k=(1:NoChan),
		Voltage(:,k)=(((ADV(k,:)'/NS)-128)-((DC(k)-128)*gain(k)/300000))*((200/CV(k))*(20000/gain(k)));
	end;
end;


