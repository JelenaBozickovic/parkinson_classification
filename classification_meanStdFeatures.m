parkinson = readtable('parkinson1.txt');
parkinson = table2array(parkinson);

pac=zeros(40,26*2);
for i = 1:40             
    pac_all=parkinson(parkinson(:,1)==i,2:27);
    pac(i,:)=[mean(pac_all),std(pac_all)];
end
lab=[ones(20,1);zeros(20,1)];

p=zeros(1,40);
skor={};
for i=1:40
    test=pac(i,:);
    test_lab=lab(i);
    train=pac;
    train(i,:)=[];
    lab_train=lab;
    lab_train(i)=[];
 
    model = fitcsvm(train, lab_train, 'standardize', 1, 'kernelfunction', 'linear');
    
    [p(i), skor{i}] = model.predict(test);
end

c=confusionmat(lab,p')
tacnost = (c(1,1)+ c(2,2))/(sum(sum(c)));
tacnost = tacnost * 100
sensitivnost = c(2,2)/ (c(2,2)+ c(2,1));
sensitivnost = sensitivnost * 100
lazni_pozitiv = c(1,2)/(c(1,2) + c(1,1))
osetljivost = c(1,1)/(c(1,2) + c(1,1))
osetljivost = osetljivost * 100
    
 