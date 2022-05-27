parkinson = readtable('parkinson1.txt');
parkinson = table2array(parkinson);
lab = parkinson(:, 29);


data_sustainedVowel_A=zeros(40,27);
data_sustainedVowel_O=zeros(40,27);
data_sustainedVowel_U=zeros(40,27);
for i = 1:40                                    
    pac_all=parkinson(parkinson(:,1)==i,1:27);
    data_sustainedVowel_A(i,:)=[pac_all(1, :)];
    data_sustainedVowel_O(i,:)=[pac_all(2, :)];
    data_sustainedVowel_U(i,:)=[pac_all(3, :)];
end
lab_A=[ones(20,1);zeros(20,1)];
lab_O=[ones(20,1);zeros(20,1)];
lab_U=[ones(20,1);zeros(20,1)];


data_sustainedVowel_ALL = [data_sustainedVowel_A; data_sustainedVowel_O; data_sustainedVowel_U];
lab_ALL=[ones(20,1);zeros(20,1);ones(20,1);zeros(20,1);ones(20,1);zeros(20,1)];
p=zeros(1,120);
skor={};


pac=zeros(40,26*2);
for i = 1:40                                    
    pac_all=data_sustainedVowel_ALL(data_sustainedVowel_ALL(:,1)==i,2:27);
    pac(i,:)=[mean(pac_all),std(pac_all)];
end
lab=[ones(10,1);zeros(10,1);ones(10,1);zeros(10,1)];


p=zeros(1,40);
skor={};
for i=1:40
    test=pac(i,:);
    test_lab=lab(i);
    train=pac;
    train(i,:)=[];
    lab_train=lab;
    lab_train(i)=[];
    
    model = fitcsvm(train, lab_train, 'standardize', 1, 'kernelfunction', 'linear', 'BoxConstraint', 70);

    [p(i), skor{i}] = model.predict(test);
end


c=confusionmat(lab,p');
tacnost = (c(1,1)+ c(2,2))/(sum(sum(c)));
tacnost = tacnost * 100
osetljivost = c(1,1)/(c(1,2) + c(1,1))
osetljivost = osetljivost * 100
sensitivnost = c(2,2)/ (c(2,2)+ c(2,1));
sensitivnost = sensitivnost * 100