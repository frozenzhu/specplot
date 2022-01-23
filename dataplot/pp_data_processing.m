% Zi Zhi: Move all settings to beginning of script

% If signal is larger than this, the data point is considered a noise from
% experiment
badpoint_threshold = 0.005;

% The baseline level is determined by average levels before t=0. This is
% the number of points before t=0.
baseline_sample_length = 22;

% The location of data files
data_files_dir = '../PT1-PumpProbe/CCl4_Solution-100uW-1550cm-1/';

%自动叠加数据+剔除奇异点+扣基线+掰零点+各向异性
%导入所有p
readfiles= dir(fullfile(data_files_dir,'*.p.dat'));
N=length(readfiles);
for i=1:N
      Q(:,:,i)=importdata(strcat(data_files_dir,readfiles(i).name));
      q{i}= Q(:,:,i)          %载入所有dat文件存取矩阵Q
end
time=Q(:,1,1);             %时间
wavenumber=Q(1,:,1);                   %波长
time(1,:)=[];                        %时间中删掉0
wavenumber(:,1)=[];                     %波长中删掉0
[a,b,c]=size(Q);       %读取矩阵Q尺寸
bad=zeros(a,b,c);         %定义坏点个数矩阵用以记录那套数据中那个位置有异常点，初值全为0
 deletebadpoint_all=zeros(a,b);
for i=1:c
      for k=2:b
          for j=2:a-20
                if abs(Q(j,k,i)-Q(j+1,k,i))<=badpoint_threshold && abs(Q(j+1,k,i)-Q(j+2,k,i))<=badpoint_threshold
                   Q(j,k,i)=Q(j,k,i);
                   Q(j+1,k,i)=Q(j+1,k,i);
                   Q(j+2,k,i)=Q(j+2,k,i);
                else
                   Q(j,k,i)=[0];
                   Q(j+1,k,i)=[0];
                   Q(j+2,k,i)=[0];                       %相邻值大于0.02认为是异常点并将后一个点删除
                   bad(j,k,i)=[1];
                   bad(j+1,k,i)=[1];   
                   bad(j+2,k,i)=[1];               %换点个数矩阵相应位置记为1
                end
           end
       end
end
for j=2:a
     for k=2:b
         for i=1:c
              deletebadpoint_all(j,k)=deletebadpoint_all(j,k)+Q(j,k,i);          %删除坏点后所有数据加和
         end
     end
end
N=zeros(a,b);                  %定义矩阵N记录加和后的数据数据中曾在那个位置删过几次异常点，初值全为0
for j=1:a
     for k=1:b
         for i=1:c-1
             if bad(j,k,i)==1;           %bad矩阵中第i个二维矩阵的第j行第k列为1即第i套数据中第j行第k列为一个异常点
                 N(j,k)=N(j,k)+1;           %N矩阵中第j行第k列数值+1，即第j行第i列删过一个
             else
                 N(j,k)=N(j,k);
             end
         end
     end
end
for j=2:a
     for k=2:b
         deletebadpoint(j,k)=deletebadpoint_all(j,k)/(c-N(j,k));          %c套数据加和取平均，第j行第k列删过N(j,k)个异常点，剩c-N(j,k)个数据加和
     end
end
deletebadpoint(1,:)=[];
deletebadpoint(:,1)=[];                   %deletebadpoint中删掉时间波长
deletebadpoint=[time,deletebadpoint];
wavenumber1=[0;wavenumber'];
wavenumber1=wavenumber1';
idealized=[wavenumber1;deletebadpoint];
p=idealized;
save p.dat -Ascii p;
%导入所有s
readfiles= dir(fullfile(data_files_dir,'*.s.dat'));
N=length(readfiles);
for i=1:N
      Q(:,:,i)=importdata(strcat(data_files_dir,readfiles(i).name));
      q{i}= Q(:,:,i)          %载入所有dat文件存取矩阵Q
end
time=Q(:,1,1);             %时间
wavenumber=Q(1,:,1);                   %波长
time(1,:)=[];                        %时间中删掉0
wavenumber(:,1)=[];                     %波长中删掉0
[a,b,c]=size(Q);       %读取矩阵Q尺寸
bad=zeros(a,b,c);         %定义坏点个数矩阵用以记录那套数据中那个位置有异常点，初值全为0
 deletebadpoint_all=zeros(a,b);
for i=1:c
      for k=2:b
          for j=2:a-2
                if abs(Q(j,k,i)-Q(j+1,k,i))<=0.005 && abs(Q(j+1,k,i)-Q(j+2,k,i))<=badpoint_threshold
                   Q(j,k,i)=Q(j,k,i);
                   Q(j+1,k,i)=Q(j+1,k,i);
                   Q(j+2,k,i)=Q(j+2,k,i);
                else
                   Q(j,k,i)=[0];
                   Q(j+1,k,i)=[0];
                   Q(j+2,k,i)=[0];                       %相邻值大于0.02认为是异常点并将后一个点删除
                   bad(j,k,i)=[1];
                   bad(j+1,k,i)=[1];   
                   bad(j+2,k,i)=[1];               %换点个数矩阵相应位置记为1
                end
           end
       end
end
for j=2:a
     for k=2:b
         for i=1:c
              deletebadpoint_all(j,k)=deletebadpoint_all(j,k)+Q(j,k,i);          %删除坏点后所有数据加和
         end
     end
end
N=zeros(a,b);                  %定义矩阵N记录加和后的数据数据中曾在那个位置删过几次异常点，初值全为0
for j=1:a
     for k=1:b
         for i=1:c-1
             if bad(j,k,i)==1;           %bad矩阵中第i个二维矩阵的第j行第k列为1即第i套数据中第j行第k列为一个异常点
                 N(j,k)=N(j,k)+1;           %N矩阵中第j行第k列数值+1，即第j行第i列删过一个
             else
                 N(j,k)=N(j,k);
             end
         end
     end
end
for j=2:a
     for k=2:b
         deletebadpoint(j,k)=deletebadpoint_all(j,k)/(c-N(j,k));          %c套数据加和取平均，第j行第k列删过N(j,k)个异常点，剩c-N(j,k)个数据加和
     end
end
deletebadpoint(1,:)=[];
deletebadpoint(:,1)=[];                   %deletebadpoint中删掉时间波长
deletebadpoint=[time,deletebadpoint];
wavenumber1=[0;wavenumber'];
wavenumber1=wavenumber1';
idealized=[wavenumber1;deletebadpoint];
s=idealized;
save s.dat -Ascii s;
%导入所保存的p,s
load('./p.dat')
load('./s.dat')
time=p(:,1);             %时间
wavenumber=p(1,:);                   %波长
p(1,:)=[];
p(:,1)=[];                   %p中删掉时间波长
s(1,:)=[];
s(:,1)=[];                    %p中删掉时间波长
time(1,:)=[];                        %时间中删掉0
wavenumber(:,1)=[];                     %波长中删掉0
a=find(time==0);                %找到时间零点位置
[b,c]=size(wavenumber);                 %波长个数
for i=0 i=1:a-22              %i行循环
       for j=0 j=1:c                          %j列循环
            if i<=a-22
              p1(i,j)=p(i,j);
                else
                    p1(i,j)=[];
           end
      end                                    %取出零点前a-20行，j列的数据
end
avep=mean(p1);                  %每列数据取平均
for i=0 i=1:a-22
       for j=0 j=1:c
            if i<=a-22
              s1(i,j)=s(i,j);
                else
                    s1(i,j)=[];
           end
      end
end
aves=mean(s1);
[a,b]=size(time);               %每列中数据个数
[c,d]=size(wavenumber);                     %每行中数据个数
 for k=1:1:a
       for j=1:1:d
          avep(k,j)=avep(1,j);              %创建每行每列均为平均数的矩阵
end
end
 for k=1:1:a
       for j=1:1:d
          aves(k,j)=aves(1,j); 
end
end
p=p-avep;           %扣基线
s=s-aves;
[M,I]=max(abs(p));         %掰零点
[N,J]=max(abs(s));
[m]=min(I);
[n]=min(J);
max_time_p=time(m);
max_time_s=time(n);
time_p=time-max_time_p;
time_s=time-max_time_s;
wavenumber1=[0;wavenumber'];
wavenumber1=wavenumber1';
p=[time_p,p];
pp=[wavenumber1;p];
s=[time_s,s];
ss=[wavenumber1;s];              %恢复原数据格式（第一行波长第一列时间）
save pp.txt -Ascii pp;               %保存数据
save ss.txt -Ascii ss;
[a,b]=size(pp);              %读取扣基线后的矩阵大小
for i=1:1:a
      for j=1:1:b
       anis(i,j)=(pp(i,j)-ss(i,j))/(pp(i,j)+2*ss(i,j));           %各向异性
      end
end
anis(1,:)=[];
anis(:,1)=[];
 aniso=[time,anis];
anisotropy=[wavenumber1;aniso];
save anisotropy.txt -Ascii anisotropy;
for i=1:1:a
      for j=1:1:b
       magangle(i,j)=(pp(i,j)+2*ss(i,j))/3;           %消除魔角
      end
end
magangle(1,:)=[];
magangle(:,1)=[];
magangle=[time,magangle];
magangle=[wavenumber1;magangle];
save magangle.txt -Ascii magangle;