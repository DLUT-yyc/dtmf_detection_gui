global tone_all h1 h2
fs=8000;
t=[0:length(tone_all)-1]/fs;   %��ʱ��Ϊ�����ź�������/ÿ���������������Ƶ�ʣ�
%����ȫ��������������ʱ����ͼ
h1=subplot(2,3,2);plot(t,tone_all);grid on;
title('������Ƶ�źŵ�ʱ��ͼ');
ylabel('Amplitude');
xlabel('time (second)');
%disp(length(tone_all))
%1421��ÿ�����ź���ռ�Ĳ�����ĸ������ж��ٸ�1421���ж��ٴΰ���
for ii=0:(length(tone_all)/1421-1)
    tone=tone_all(1+1421*ii:1421*(ii+1));
    %disp(length(tone))
    tone=tone(401:end);
    Ak=2*abs(fft(tone))/length(tone);Ak(1)=Ak(1)/2;
    f=[0:1:(length(tone)-1)/2]*fs/length(tone);
    h2=subplot(2,3,3);plot(f,Ak(1:(length(tone)+1)/2));grid on
    title('������Ƶ�źŵ�Ƶ��ͼ');
    ylabel('Amplitude');
    xlabel('frequency (Hz)');
    axis([500 2000 0 1]);
    soundsc(tone,fs);
    pause(0.25);
end

% Save tone_all.wav
audiowrite('tone_all.wav',(tone_all')/2,fs);