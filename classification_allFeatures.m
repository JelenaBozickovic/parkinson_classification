c=zeros(2);
skor = {};
p = {};
cnt=0;

for i = 1:40
    
    load(strcat('train_',num2str(i),'.mat'));
    load(strcat('test_',num2str(i),'.mat'));
    lab_test = test(:, 29);
    lab_train = train(:, 29);

    train = train(:, 2:27);
    test = test(:, 2:27);
    
    model = fitcsvm(train, lab_train  , 'BoxConstraint', 10); 
    [p{i}, skor{i}] = model.predict(test);
    c = c + confusionmat(lab_test, p{i});
   
end

tacnost = (c(1,1)+ c(2,2))/(sum(sum(c)));
tacnost = tacnost * 100
sensitivnost = c(2,2)/ (c(2,2)+ c(2,1));
sensitivnost = sensitivnost * 100
osetljivost = c(1,1)/(c(1,2) + c(1,1))
osetljivost = osetljivost * 100
    
    
    