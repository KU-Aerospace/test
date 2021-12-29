%-------------------------------------------------------------------------
% An illustration of Gibbs phenomenon.
% This script loads any windows compatible .wav file
% 
% The user is prompted for the name of the .wav file to load.
% 
% The time domain of the signal is displayed in one window, 
% and the frequency spectrum of the signal is displayed in another window.
%
% Raymond Roberts and Graham Roberts
% students in Mechanical Engineering at Curtin University of Technology,
% September 1996.
%-------------------------------------------------------------------------

clear all
echo off

% **************************************************************************
%  Load the .wav file into a MATLAB vector
%
% we first have to prompt the user for the name of the .wav file to analyse
[filename, path] = uigetfile('*.wav');

if filename==0
	% ie: cancelled operation then do nothing
else

	% rearrange path and filename of desired mat file
	wavefile = [path,filename];

	% load file into workspace
	eval('fid=fopen(wavefile,''rb'');');
end

if fid == -1
	error('Can''t open .WAV file for input!');
end;

% if there is no error, then load the .wav file
%
% chan1, chan2 are the two data streams stored in the .wav file
% dt is the sample period (in seconds)
% format is the format of the .wav file
%
if fid ~= -1 
	% read riff chunk
	header=fread(fid,4,'uchar');
	header=fread(fid,1,'ulong');
	header=fread(fid,4,'uchar');
	
	% read format sub-chunk
	header=fread(fid,4,'uchar');
	header=fread(fid,1,'ulong');
	
	format(1)=fread(fid,1,'ushort');	% PCM format 
	format(2)=fread(fid,1,'ushort');        % 1 channel
	fs=fread(fid,1,'ulong');        	% samples per second
	dt = 1/fs;
	format(3)=fs;
	format(4)=fread(fid,1,'ulong'); 	% average bytes per second
	format(5)=fread(fid,1,'ushort');        % block alignment
	format(6)=fread(fid,1,'ushort');        % bits per sample

	% read header
	header=fread(fid,4,'uchar');
	nsamples=fread(fid,1,'ulong');
	
	if format(6)==8	% 8 bit data
		% read data in 8 bit format
		d=fread(fid,nsamples,'uchar');
	elseif format(6)==16 % 16 bit data
		% read data in 16 bit format
		d=fread(fid,nsamples,'short');
	end

	% close file
	fclose(fid);

	% reorder data if in two channel mode
	if format(2)==2
		chan1 = d(1:2:length(d));
		chan2 = d(2:2:length(d));
	elseif format(1)==1
		chan1 = d;
	end

% *********************************************************************************
% now to display the time signal of the data contained with the .wav file
%
	if format(2)==2
		% two channels of data to display one figure

		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		% Display the first channel time signal

		% create new graphics window
		chan1figtitle = ['Time Domain - ',wavefile,' (Channel 1)'];
		hf = figure('Name',chan1figtitle,'NumberTitle','on','Color','white',...
		'Pointer','crosshair','Units','normal','Position',[0.1,0.5,0.8,0.35],...
		'InvertHardCopy','off','PaperType','a4letter','PaperUnits','centimeters',...
		'PaperPosition',[3.0,10.0,14.0,12.0]);

		% determine time domain  scaling parameters

		ymax = 1.2*max(chan1);
		ymin = 1.2*min(chan1);
		if ymax<0.0
			ymax = ymax/(1.2*1.2);
		end
		if ymin>0.0
			ymin = ymin/(1.2*1.2);
		end

		npnts = length(chan1);
		xmin = 0.0;
		xmax = npnts*dt;
		t = 0:dt:dt*(npnts-1);

		% position axes within figure window
		ht = axes('Parent',hf,'Position',[0.1 0.2 0.85 0.75]);

		% plot time data
		plot(t,chan1,'g');

		% specify axes parameters
		set(ht,'XLim',[xmin xmax],'XColor','black');
		set(ht,'YLim',[ymin ymax],'YColor','black');

		htx = text(0,0,'Time (sec)');
		set(htx,'Color','black');

		hty = text(0,0,'Amplitude');
		set(hty,'Color','black');
		set(hty,'Rotation',+90.0);

		set(ht,'XLabel',htx,'YLabel',hty);

		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		% now display the second channel data

		% create new graphics window
		chan2figtitle = ['Time Domain - ',wavefile,' (Channel 2)'];
		hf = figure('Name',chan2figtitle,'NumberTitle','on','Color','white',...
		'Pointer','crosshair','Units','normal','Position',[0.1,0.07,0.8,0.35],...
		'InvertHardCopy','off','PaperType','a4letter','PaperUnits','centimeters',...
		'PaperPosition',[3.0,10.0,14.0,12.0]);

		% determine time domain  scaling parameters

		ymax = 1.2*max(chan2);
		ymin = 1.2*min(chan2);
		if ymax<0.0
			ymax = ymax/(1.2*1.2);
		end
		if ymin>0.0
			ymin = ymin/(1.2*1.2);
		end

		npnts = length(chan2);
		xmin = 0.0;
		xmax = npnts*dt;
		t = 0:dt:dt*(npnts-1);

		% position axes within figure window
		ht = axes('Parent',hf,'Position',[0.1 0.2 0.85 0.75]);

		% plot time data
		plot(t,chan2,'r');

		% specify axes parameters
		set(ht,'XLim',[xmin xmax],'XColor','black');
		set(ht,'YLim',[ymin ymax],'YColor','black');

		htx = text(0,0,'Time (sec)');
		set(htx,'Color','black');

		hty = text(0,0,'Amplitude');
		set(hty,'Color','black');
		set(hty,'Rotation',+90.0);

		set(ht,'XLabel',htx,'YLabel',hty);


        elseif format(2)==1
		% one channel of data to display so only need one figure

		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		% display the time signal stored in the .wav file

		% create new graphics window
		chan1figtitle = ['Time Domain - ',wavefile];
		hf = figure('Name',chan1figtitle,'NumberTitle','on','Color','white',...
		'Pointer','crosshair','Units','normal','Position',[0.1,0.07,0.8,0.35],...
		'InvertHardCopy','off','PaperType','a4letter','PaperUnits','centimeters',...
		'PaperPosition',[3.0,10.0,14.0,12.0]);

		% determine time domain  scaling parameters

		ymax = 1.2*max(chan1);
		ymin = 1.2*min(chan1);
		if ymax<0.0
			ymax = ymax/(1.2*1.2);
		end
		if ymin>0.0
			ymin = ymin/(1.2*1.2);
		end

		npnts = length(chan1);
		xmin = 0.0;
		xmax = npnts*dt;
		t = 0:dt:dt*(npnts-1);

		% position axes within figure window
		ht = axes('Parent',hf,'Position',[0.1 0.2 0.85 0.75]);

		% plot time data
		plot(t,chan1,'b');

		% specify axes parameters
		set(ht,'XLim',[xmin xmax],'XColor','black');
		set(ht,'YLim',[ymin ymax],'YColor','black');

		htx = text(0,0,'Time (sec)');
		set(htx,'Color','black');

		hty = text(0,0,'Amplitude');
		set(hty,'Color','black');
		set(hty,'Rotation',+90.0);

		set(ht,'XLabel',htx,'YLabel',hty);
        end

% *********************************************************************************
% now to display the spectra of the data contained with the .wav file
%
	if format(2)==2
		% two channels of data to display one figure

		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		% Display the first channel power spectrum

		% where
		%      chan1 is the time vector
		%      lwin is the length of the time window function
		%      dt is the sample time period

		lwin = 2048;

		% number of loops through data
		n = fix(length(chan1)/lwin);

		% reshape time vector into matrix of n columns of length lwin
		x = reshape(chan1(1:lwin*n),lwin,n); 
		xwin = zeros(size(x));

		% window columns 
		% use a Hanning window
		win = .5*(1 - cos(2*pi*(1:lwin)'/(lwin+1)));;
		for k=1:n
			xwin(1:lwin,k) = win.*x(:,k);
		end

		% compute the fft of all the columns
		f = fft(xwin);
 
		% eliminating negative frequencies
		f(1+lwin/2:lwin,:) = [];
 
		% obtain the complex modulus squared (power)
		ps = abs(f).^2;

		% sum the columns together to obtain the ensemble average
		% scaled in terms of power spectral density, double +ve frequencies
		[m,n] = size(ps);
		if (m==1) | (n==1)
			psa = ps*(dt/lwin);
			psa(2:lwin/2) = psa(2:lwin/2)*2;
		else
			psa = sum(ps')*(dt/lwin);
			psa(2:lwin/2) = psa(2:lwin/2)*2;
		end

		% display power spectrum
		% display spectra using linear x axis and log y axis
		df = 1/(dt*lwin);
		np = lwin/2;
		f = 0:df:(np-1)*df;

		% control axis scaling
		mn = min(10*log10(psa(1:np)));
		if mn<0.0, 
		       	mn=mn*1.2;
		else
		       	mn=mn/1.2;
		end
		mx = max(10*log10(psa(1:np)));
		if mx>0.0,
		       	mx=mx*1.2;
		else
		       	mx=mx/1.2;
		end

		% create new graphics window
		chan1figtitle = ['Power Spectrum - ',wavefile, ' (Channel 1)'];
		hf = figure('Name',chan1figtitle,'NumberTitle','on','Color','white',...
		'Pointer','crosshair','Units','normal','Position',[0.3,0.2,0.65,0.65],...
		'InvertHardCopy','off');

		% create text objects for interactive cursor x and y axis values
		hclx = text(0.6,0.9,'');
		hcly = text(0.93,0.9,'');
		set(hclx,'Color','red');
		set(hcly,'Color','red');

		hcx = text(0.57,0.97,'');
		hcy = text(0.9,0.97,'');
		set(hcx,'Color','blue');
		set(hcy,'Color','blue');

		% position axes within figure window
		ht = axes('Parent',hf,'Position',[0.2 0.1 0.75 0.85]);

		plot(f,10*log10(psa(1:np)),'-g');

		% specify axes parameters
		set(ht,'XLim',[0.0 df*(np-1)],'XColor','black');
		set(ht,'YLim',[mn mx],'YColor','black');

		htx = text(0,0,'Frequency (Hz)');
		set(htx,'Color','black');

		hty = text(0,0,'Amplitude (dB)');
		set(hty,'Color','black');
		set(hty,'Rotation',+90.0);

		set(ht,'XLabel',htx,'YLabel',hty);

		textvar = 'FREQ';
		% create cursor control
		hcur = uicontrol(hf,'Style','Pushbutton','Position',[0.02 0.88 0.1 0.07],...
		'Callback','mouse','String','cursor','Units','normalized');

		% create zoom push button control
		hz = uicontrol(hf,'Style','Pushbutton','Position',[0.02 0.78 0.1 0.07],...
		'Callback','zoom','String','zoom','Units','normalized');

		% create push button control for exiting
		hz = uicontrol(hf,'Style','Pushbutton','Position',[0.02 0.68 0.1 0.07],...
		'Callback','close','String','close','Units','normalized');

		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		% Display the second channel power spectrum

		% where
		%      chan2 is the time vector
		%      lwin is the length of the time window function
		%      dt is the sample time period

		lwin = 2048;

		% number of loops through data
		n = fix(length(chan2)/lwin);

		% reshape time vector into matrix of n columns of length lwin
		x = reshape(chan2(1:lwin*n),lwin,n); 
		xwin = zeros(size(x));

		% window columns 
		% use a Hanning window
		win = .5*(1 - cos(2*pi*(1:lwin)'/(lwin+1)));;
		for k=1:n
			xwin(1:lwin,k) = win.*x(:,k);
		end

		% compute the fft of all the columns
		f = fft(xwin);
 
		% eliminating negative frequencies
		f(1+lwin/2:lwin,:) = [];
 
		% obtain the complex modulus squared (power)
		ps = abs(f).^2;

		% sum the columns together to obtain the ensemble average
		% scaled in terms of power spectral density, double +ve frequencies
		[m,n] = size(ps);
		if (m==1) | (n==1)
			psa = ps*(dt/lwin);
			psa(2:lwin/2) = psa(2:lwin/2)*2;
		else
			psa = sum(ps')*(dt/lwin);
			psa(2:lwin/2) = psa(2:lwin/2)*2;
		end

		% display power spectrum
		% display spectra using linear x axis and log y axis
		df = 1/(dt*lwin);
		np = lwin/2;
		f = 0:df:(np-1)*df;

		% control axis scaling
		mn = min(10*log10(psa(1:np)));
		if mn<0.0, 
		       	mn=mn*1.2;
		else
		       	mn=mn/1.2;
		end
		mx = max(10*log10(psa(1:np)));
		if mx>0.0,
		       	mx=mx*1.2;
		else
		       	mx=mx/1.2;
		end

		% create new graphics window
		chan2figtitle = ['Power Spectrum - ',wavefile, ' (Channel 2)'];
		hf = figure('Name',chan2figtitle,'NumberTitle','on','Color','white',...
		'Pointer','crosshair','Units','normal','Position',[0.3,0.0,0.65,0.65],...
		'InvertHardCopy','off');

		% create text objects for interactive cursor x and y axis values
		hclx = text(0.6,0.9,'');
		hcly = text(0.93,0.9,'');
		set(hclx,'Color','red');
		set(hcly,'Color','red');

		hcx = text(0.57,0.97,'');
		hcy = text(0.9,0.97,'');
		set(hcx,'Color','blue');
		set(hcy,'Color','blue');

		% position axes within figure window
		ht = axes('Parent',hf,'Position',[0.2 0.1 0.75 0.85]);

		plot(f,10*log10(psa(1:np)),'-r');

		% specify axes parameters
		set(ht,'XLim',[0.0 df*(np-1)],'XColor','black');
		set(ht,'YLim',[mn mx],'YColor','black');

		htx = text(0,0,'Frequency (Hz)');
		set(htx,'Color','black');

		hty = text(0,0,'Amplitude (dB)');
		set(hty,'Color','black');
		set(hty,'Rotation',+90.0);

		set(ht,'XLabel',htx,'YLabel',hty);

		textvar = 'FREQ';
		% create cursor control
		hcur = uicontrol(hf,'Style','Pushbutton','Position',[0.02 0.88 0.1 0.07],...
		'Callback','mouse','String','cursor','Units','normalized');

		% create zoom push button control
		hz = uicontrol(hf,'Style','Pushbutton','Position',[0.02 0.78 0.1 0.07],...
		'Callback','zoom','String','zoom','Units','normalized');

		% create push button control for exiting
		hz = uicontrol(hf,'Style','Pushbutton','Position',[0.02 0.68 0.1 0.07],...
		'Callback','close','String','close','Units','normalized');



        elseif format(2)==1
		% one channel of data to display so only need one figure

		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		% Display the power spectrum

		% where
		%      chan1 is the time vector
		%      lwin is the length of the time window function
		%      dt is the sample time period

		lwin = 2048;

		% number of loops through data
		n = fix(length(chan1)/lwin);

		% reshape time vector into matrix of n columns of length lwin
		x = reshape(chan1(1:lwin*n),lwin,n); 
		xwin = zeros(size(x));

		% window columns 
		% use a Hanning window
		win = .5*(1 - cos(2*pi*(1:lwin)'/(lwin+1)));;
		for k=1:n
			xwin(1:lwin,k) = win.*x(:,k);
		end

		% compute the fft of all the columns
		f = fft(xwin);
 
		% eliminating negative frequencies
		f(1+lwin/2:lwin,:) = [];
 
		% obtain the complex modulus squared (power)
		ps = abs(f).^2;

		% sum the columns together to obtain the ensemble average
		% scaled in terms of power spectral density, double +ve frequencies
		[m,n] = size(ps);
		if (m==1) | (n==1)
			psa = ps*(dt/lwin);
			psa(2:lwin/2) = psa(2:lwin/2)*2;
		else
			psa = sum(ps')*(dt/lwin);
			psa(2:lwin/2) = psa(2:lwin/2)*2;
		end

		% display power spectrum
		% display spectra using linear x axis and log y axis
		df = 1/(dt*lwin);
		np = lwin/2;
		f = 0:df:(np-1)*df;

		% control axis scaling
		mn = min(10*log10(psa(1:np)));
		if mn<0.0, 
		       	mn=mn*1.2;
		else
		       	mn=mn/1.2;
		end
		mx = max(10*log10(psa(1:np)));
		if mx>0.0,
		       	mx=mx*1.2;
		else
		       	mx=mx/1.2;
		end

		% create new graphics window
		chan1figtitle = ['Power Spectrum - ',wavefile];
		hf = figure('Name',chan1figtitle,'NumberTitle','on','Color','white',...
		'Pointer','crosshair','Units','normal','Position',[0.3,0.2,0.65,0.65],...
		'InvertHardCopy','off');

		% create text objects for interactive cursor x and y axis values
		hclx = text(0.6,0.9,'');
		hcly = text(0.93,0.9,'');
		set(hclx,'Color','red');
		set(hcly,'Color','red');

		hcx = text(0.57,0.97,'');
		hcy = text(0.9,0.97,'');
		set(hcx,'Color','blue');
		set(hcy,'Color','blue');

		% position axes within figure window
		ht = axes('Parent',hf,'Position',[0.2 0.1 0.75 0.85]);

		plot(f,10*log10(psa(1:np)),'-b');

		% specify axes parameters
		set(ht,'XLim',[0.0 df*(np-1)],'XColor','black');
		set(ht,'YLim',[mn mx],'YColor','black');

		htx = text(0,0,'Frequency (Hz)');
		set(htx,'Color','black');

		hty = text(0,0,'Amplitude (dB)');
		set(hty,'Color','black');
		set(hty,'Rotation',+90.0);

		set(ht,'XLabel',htx,'YLabel',hty);

		textvar = 'FREQ';
		% create cursor control
		hcur = uicontrol(hf,'Style','Pushbutton','Position',[0.02 0.88 0.1 0.07],...
		'Callback','mouse','String','cursor','Units','normalized');

		% create zoom push button control
		hz = uicontrol(hf,'Style','Pushbutton','Position',[0.02 0.78 0.1 0.07],...
		'Callback','zoom','String','zoom','Units','normalized');

		% create push button control for exiting
		hz = uicontrol(hf,'Style','Pushbutton','Position',[0.02 0.68 0.1 0.07],...
		'Callback','close','String','close','Units','normalized');

	end


end     