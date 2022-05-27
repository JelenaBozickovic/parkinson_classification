parkinson = readtable('parkinson1.txt');
parkinson = table2array(parkinson);
lab = parkinson(:, 29);


%first row of each patient represents sustained vowel a 
%data_sustainedVowel = parkinson([1, 27, 53, 82, 108, 134, 160,], :);

data_sustainedVowel_A=zeros(40,26);
for i = 1:40                                    
    pac_all=parkinson(parkinson(:,1)==i,2:27);
    data_sustainedVowel_A(i,:)=[pac_all(1, :)];
end
lab_A=[ones(20,1);zeros(20,1)];


p=zeros(1,40);
skor={};
for i=1:40
    test=data_sustainedVowel_A(i,:);
    test_lab=lab_A(i);
    train=data_sustainedVowel_A;
    train(i,:)=[];
    lab_train=lab_A;
    lab_train(i)=[];
    
    model = fitcsvm(train, lab_train, 'BoxConstraint', 20);      
    [p(i), skor{i}] = model.predict(test);
end
c=confusionmat(lab_A,p');
tacnost = (c(1,1)+ c(2,2))/(sum(sum(c)));
tacnost = tacnost * 100



data_sustainedVowel_O=zeros(40,26);
for i = 1:40                                    
    pac_all=parkinson(parkinson(:,1)==i,2:27);
    data_sustainedVowel_O(i,:)=[pac_all(2, :)];
end
lab_O=[ones(20,1);zeros(20,1)];

p=zeros(1,40);
skor={};
for i=1:40
    test=data_sustainedVowel_O(i,:);
    test_lab=lab_O(i);
    train=data_sustainedVowel_O;
    train(i,:)=[];
    lab_train=lab_O;
    lab_train(i)=[];
    
    model = fitcsvm(train, lab_train);              
    [p(i), skor{i}] = model.predict(test);
end
c=confusionmat(lab_O,p');
tacnost = (c(1,1)+ c(2,2))/(sum(sum(c)));
tacnost = tacnost * 100


data_sustainedVowel_U=zeros(40,26);
for i = 1:40                                    
    pac_all=parkinson(parkinson(:,1)==i,2:27);
    data_sustainedVowel_U(i,:)=[pac_all(3, :)];
end
lab_U=[ones(20,1);zeros(20,1)];

p=zeros(1,40);
skor={};
for i=1:40
    test=data_sustainedVowel_U(i,:);
    test_lab=lab_U(i);
    train=data_sustainedVowel_U;
    train(i,:)=[];
    lab_train=lab_U;
    lab_train(i)=[];
    
    model = fitcsvm(train, lab_train);               
    [p(i), skor{i}] = model.predict(test);
end
c=confusionmat(lab_U,p');
tacnost = (c(1,1)+ c(2,2))/(sum(sum(c)));
tacnost = tacnost * 100


data_sustainedVowel_ALL = [data_sustainedVowel_A; data_sustainedVowel_O; data_sustainedVowel_U];
lab_ALL=[ones(20,1);zeros(20,1);ones(20,1);zeros(20,1);ones(20,1);zeros(20,1)];

p=zeros(1,120);
skor={};
for i=1:120
    test=data_sustainedVowel_ALL(i,:);
    test_lab=lab_ALL(i);
    train=data_sustainedVowel_ALL;
    train(i,:)=[];
    lab_train=lab_ALL;
    lab_train(i)=[];
    
    model = fitcsvm(train, lab_train, 'BoxConstraint', 15);              
    [p(i), skor{i}] = model.predict(test);
end


c=confusionmat(lab_ALL,p');
tacnost = (c(1,1)+ c(2,2))/(sum(sum(c)));
tacnost = tacnost * 100
sensitivnost = c(2,2)/ (c(2,2)+ c(2,1));
sensitivnost = sensitivnost * 100
osetljivost = c(1,1)/(c(1,2) + c(1,1))
osetljivost = osetljivost * 100


    