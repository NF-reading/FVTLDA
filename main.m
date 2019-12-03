function main(r1,r2,k1,k2,rate)
%main(r1=0.001,r2=0.001,k1=0.001,k2=0.007,rate=0.3)
[~,m_lpair] = xlsread('miRNA-lncRNA.xlsx');
[~,m_dpair] = xlsread('miRNA-disease.xlsx');
[~,l_dpair] = xlsread('lncRNA-disease.xlsx');
[ml1,ml2,ml3,ml4] = dataconvert(m_lpair);
[md1,md2,md3,md4] = dataconvert(m_dpair);
[ld1,ld2,ld3,ld4] = dataconvert(l_dpair);
save ld1 ld1;
save ld2 ld2;
lengthld = length(ld1);
km1 = GaussianSimi(ml2);
load('disSemSim'); %373x373
load('new_disSemSim'); %95x95
km2=func_Sim(md2',length(md2(:,1)),disSemSim);
normkm1 = SumnormalM(km1,1);
normml = SumnormalM(ml2,2);
normkm2 = SumnormalM(km2,1);
normmd = SumnormalM(md2,2);
ML = mlRelation(normkm1',normml,r1);
MD = mlRelation(normkm2',normmd,r2);
[pp,qq] = size(ld2);
feature_vector=[];
clear m_lpair m_dpair l_dpair ml1 ml2 md1 km1 km2 km21 normkm1 normkm2 normml normmd i j;
for q=1:qq
    test=[];
    test1=[];
    for p=1:pp
         lncName = char(ld3(p));
         l_index = find(strcmp(ml4,lncName));
         l_vector = ML(:,l_index);
         test = [test,l_vector];
    end
    disName = char(ld4(q));
    d_index = find(strcmp(md4,disName)==1);
    d_vector = MD(:,d_index);
    for line = 1:length(test(1,:))
        test1(:,line)=test(:,line).*d_vector;
    end
    feature_vector=[feature_vector,test1];
end
clear d_index d_vector disName l_index l_vector lncName line p q test test1
l_lsimi=func_Sim(ld2',length(ld2(:,1)),new_disSemSim);
outputdata=RefluxLD(ld2,l_lsimi,k1,k2,rate);
output1 = mapminmax(outputdata,0,1)';
%MLR
input=[ones(length(output1),1), feature_vector'];
[b,bint,r,rint,stats]=regress(output1,input);
B1 = b(2:length(b),:)';
 for i=1:length(input(:,1))
    outputscore(1,i)=b(1)+B1*input(i,2:length(input(1,:)))';
 end
outputscore = mapminmax(outputscore,0,1);

kn_index=find(outputdata>=1);
for i=1:length(kn_index)
    outputscore(kn_index(i))=-100;
end

prediction{1,1}=char("score");
prediction{1,2}=char("disease");
prediction{1,3}=char("lncRNA");
ls=2;
for i=1:qq
    for j=1:length(find(ld2(:,i)==0))
    [score,index]=max(outputscore((i-1)*pp+1:i*pp));
    index
    d_in=i;
    l_in=index;
    d_Name = char(ld4{d_in});
    l_Name = char(ld3{l_in});
    prediction(ls,1)=num2cell(score);
    prediction(ls,2)=cellstr(d_Name);
    prediction(ls,3)=cellstr(l_Name);
    ls=ls+1;
    outputscore(index+(i-1)*pp)=-10;
    end
end
prediction %print

%ANN
% input1=feature_vector;
% net = feedforwardnet(10);
% net = init(net);
% net.trainParam.epochs = 100;
% net.trainParam.max_fail=15;
% net.trainParam.goal=0.001
% %net.trainParam.showWindow = false; 
% net.trainParam.showCommandLine = false; 
% 
% [net,tr] = train(net,input1,output1);
% outputscore = sim(net,input1);
% outputscore = mapminmax(outputscore,0,1);
% kn_index=find(outputdata>=1);
% for i=1:length(kn_index)
%     outputscore(kn_index(i))=-100;
% end
% 
% prediction{1,1}=char("score");
% prediction{1,2}=char("disease");
% prediction{1,3}=char("lncRNA");
% ls=2;
% for i=1:qq
%     for j=1:length(find(ld2(:,i)==0))
%     [score,index]=max(outputscore((i-1)*pp+1:i*pp));
%     d_in=i;
%     l_in=index;
%     d_Name = char(ld4{d_in});
%     l_Name = char(ld3{l_in});
%     prediction(ls,1)=num2cell(score);
%     prediction(ls,2)=cellstr(d_Name);
%     prediction(ls,3)=cellstr(l_Name);
%     ls=ls+1;
%     outputscore(index+(i-1)*pp)=-10;
%     end
% end
% prediction  %print
end
