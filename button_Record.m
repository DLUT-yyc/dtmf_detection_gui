global tone_all h1 h2
fs=8000;
t=[0:length(tone_all)-1]/fs;   %总时间为所有信号样本点/每秒采样个数（采样频率）
%绘制全部按键加起来的时域谱图
h1=subplot(2,3,2);plot(t,tone_all);grid on;
title('输入音频信号的时域图');
ylabel('Amplitude');
xlabel('time (second)');
%disp(length(tone_all))
%1421是每个子信号所占的采样点的个数，有多少个1421就有多少次按键
for ii=0:(length(tone_all)/1421-1)
    tone=tone_all(1+1421*ii:1421*(ii+1));
    %disp(length(tone))
    tone=tone(401:end);
    Ak=2*abs(fft(tone))/length(tone);Ak(1)=Ak(1)/2;
    f=[0:1:(length(tone)-1)/2]*fs/length(tone);
    h2=subplot(2,3,3);plot(f,Ak(1:(length(tone)+1)/2));grid on
    title('输入音频信号的频谱图');
    ylabel('Amplitude');
    xlabel('frequency (Hz)');
    axis([500 2000 0 1]);
    soundsc(tone,fs);
    pause(0.25);
end

% Save tone_all.wav
audiowrite('tone_all.wav',(tone_all')/2,fs);