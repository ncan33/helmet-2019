T = readtable('raw_data_project.xlsx');
rawdata = T.Variables;

deg_h_f = rawdata(:,1); %deg_h_f = head angle no helmet
w_f = zeros(119,1);

for i = 1:119
    w_f(i) = (deg_h_f(i+1)-deg_h_f(i))/(1/100); %delta_theta/delta_time
end %w_f = angular velocity NO HELMET (UNITS: degrees/sec)

deg_h_t = rawdata(:,4); %deg_h_t = head angle with helmet
w_t = zeros(119,1);

for i = 1:119
    w_t(i) = (deg_h_t(i+1)-deg_h_t(i))/(1/100); %delta_theta/delta_time
end %w_t = angular velocity WITH HELMET (UNITS: degrees/sec)

t = 0.005:0.01:1.185; %time vector (UNITS: seconds)

plot(t,w_f,t,w_t,'LineWidth',1.6)
title('Rotational Velocity vs. Time','FontSize',14)
xlabel('Time (seconds)','FontSize',12)
ylabel('Rotational Velocity (°/s)','FontSize',12)
legend('NO HELMET','WITH HELMET')
grid on

p = ttest(w_f,w_t);
disp(p)