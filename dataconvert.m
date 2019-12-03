function [outdata1,outdata2,outdata3,outdata4]=dataconvert(indata)
B1=unique(indata(:,1));
for i=1:length(B1)   
    outdata3{i,1}=B1{i};
end
B2=unique(indata(:,2));
for i=1:length(B2)   
    outdata4{i,1}=B2{i};
end
k=length(indata);
n=length(B1);
m=length(B2);
for i=1:k
	sou=indata{i,1};
	tar=indata{i,2};
	index1=find(strcmp(B1,sou));
	index2=find(strcmp(B2,tar));
	knownlncdis(i,1)=index1;
	knownlncdis(i,2)=index2;
	dataset(index1,index2)=1;
end
outdata1=knownlncdis;
outdata2=dataset;
