global keyNames tone_all h1 h2
fs=8000;
t=[0:1:204*5]/fs;   %每个子信号给的时间
x=zeros(1,length(t));
x(1)=1;

dtmf.keys = ... 
   ['1','2','3','A';
    '4','5','6','B';
    '7','8','9','C';
    '*','0','#','D'];

dtmf.colTones = ones(4,1)*[1209,1336,1477,1633];   %列向量
dtmf.rowTones = [697;770;852;941]*ones(1,4);       %行向量

keyName = keyNames(length(keyNames));
[r,c] = find(dtmf.keys==keyName); 
%根据按键将高低频率叠加，合成声音信号
tone=filter([0 sin(2*pi*dtmf.rowTones(r,c)/fs) ],[1 -2*cos(2*pi*dtmf.rowTones(r,c)/fs) 1],x) + filter([0 sin(2*pi*dtmf.colTones(r,c)/fs) ],[1 -2*cos(2*pi*dtmf.colTones(r,c)/fs) 1],x);
%disp(tone)
soundsc(tone,fs);   %以fs=8000的采样频率播放合成的tone
tone_all=[tone_all,zeros(1,400),tone];    %将新tone与原有的tone_all中间间隔400个0隔开加在后面

%绘制时域图
h1=subplot(2,3,2);plot(t,tone);grid on;
title('输入音频信号的时域图');
ylabel('Amplitude');
xlabel('time (second)');
axis([0 0.035 -2 2]);

%绘制频谱图
Ak=2*abs(fft(tone))/length(tone);Ak(1)=Ak(1)/2;
f=[0:1:(length(tone)-1)/2]*fs/length(tone);
h2=subplot(2,3,3);plot(f,Ak(1:(length(tone)+1)/2));grid on
title('输入音频信号的频谱图');
ylabel('Amplitude');
xlabel('frequency (Hz)');
axis([500 2000 0 1]);