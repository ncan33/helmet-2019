mm_b_f = rawdata(:,2); %body position no helmet IN MILLIMETERS
b_f = mm_b_f./1000; %b_f = body position no helmet
vb_f = zeros(119,1);

for i = 1:119
    vb_f(i) = (b_f(i+1)-b_f(i))/(1/100); %delta_x/delta_time
end %vb_f = body velocity NO HELMET (UNITS: m/sec)

mm_b_t = rawdata(:,5); %body position with helmet IN MILLIMETERS
b_t = mm_b_t./1000; %b_t = body position with helmet
vb_t = zeros(119,1);

for i = 1:119
    vb_t(i) = (b_t(i+1)-b_t(i))/(1/100); %delta_x/delta_time
end %vb_t = body velocity WITH HELMET (UNITS: m/sec)

t = 0.005:0.01:1.185; %time vector (UNITS: seconds)

plot(t,vb_f,t,vb_t,'LineWidth',1.6)