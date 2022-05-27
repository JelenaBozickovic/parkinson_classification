Parkinson = readtable('parkinson1.txt');
Parkinson = table2array(Parkinson);

%% dijagnoza 0 ili 1

ImaParkinson = Parkinson(1:520, 2:end-2);  
NemaParkinson = Parkinson(521:end, 2:end-2);

%% frekvencijski parametri
    
    iqr_opsegPF_p = zeros(1,5);
    for i = 1:5
        iqr_opsegPF_p(i) = iqr(ImaParkinson(:,i));
    end
    

    iqr_opsegPF_n = zeros(1,5);
    for i = 1:5
        iqr_opsegPF_n(i) = iqr(NemaParkinson(:,i));
    end
    

%% pulsni parametri

    iqr_opsegPP_p = zeros(1,4);
    for i = 6:9
        iqr_opsegPP_p(i-5) = iqr(ImaParkinson(:,i));
    end

    iqr_opsegPP_n = zeros(1,4);
    for i = 6:9
        iqr_opsegPP_n(i-5) = iqr(NemaParkinson(:,i));
    end
   
%% parametri amplitude

    iqr_opsegPA_p = zeros(1,6);
    for i = 10:15
        iqr_opsegPA_p(i-9) = iqr(ImaParkinson(:,i));
    end

    iqr_opsegPA_n = zeros(1,6);
    for i = 10:15
        iqr_opsegPA_n(i-9) = iqr(NemaParkinson(:,i));
    end
      
%% parametri naglasenosti

    iqr_opsegPN_p = zeros(1,3);
    for i = 16:18
        iqr_opsegPN_p(i-15) = iqr(ImaParkinson(:,i));
    end
 
    iqr_opsegPN_n = zeros(1,3);
    for i = 16:18
        iqr_opsegPN_n(i-15) = iqr(NemaParkinson(:,i));
    end
    
%% parametri pica

    iqr_opsegPI_p = zeros(1,5);
    for i = 19:23
        iqr_opsegPI_p(i-18) = iqr(ImaParkinson(:,i));
    end
    
    iqr_opsegPI_n = zeros(1,5);
    for i = 19:23
        iqr_opsegPI_n(i-18) = iqr(NemaParkinson(:,i));
    end

%% harmonijski parametar

    iqr_opsegPH_p = zeros(1,3);
    for i = 24:26
        iqr_opsegPH_p(i-23) = iqr(ImaParkinson(:,i));
    end
 
    iqr_opsegPH_n = zeros(1,3);
    for i = 24:26
        iqr_opsegPH_n(i-23) = iqr(NemaParkinson(:,i));
    end
  
    %% dinamicki opseg
    d_opseg_p = max(ImaParkinson) - min(ImaParkinson);
    f_d_opseg_p = d_opseg_p(1:5); %frekvencijski parametri
    p_d_opseg_p = d_opseg_p(6:9); %pulsni parametri ..
    a_d_opseg_p = d_opseg_p(10:15);
    n_d_opseg_p = d_opseg_p(16:18);
    pi_d_opseg_p = d_opseg_p(19:23);
    h_d_opseg_p = d_opseg_p(24:26);
    
    
    d_opseg_n = max(NemaParkinson) - min(NemaParkinson);
    f_d_opseg_n = d_opseg_n(1:5); %frekvencijski parametri
    p_d_opseg_n = d_opseg_n(6:9); %pulsni parametri ..
    a_d_opseg_n = d_opseg_n(10:15);
    n_d_opseg_n = d_opseg_n(16:18);
    pi_d_opseg_n = d_opseg_n(19:23);
    h_d_opseg_n = d_opseg_n(24:26);
   
    %% Provera koja vrednost se javlja u vise od 10% uzoraka.
    [M_p,F_p]=mode(ImaParkinson);
    
    [M_n,F_n]=mode(NemaParkinson);
    
    %% box plot
    
    for i = 1:length(ImaParkinson)
         figure,boxplot(ImaParkinson(:, i))
    end
    
    for i = 1:length(NemaParkinson)
       figure, boxplot(NemaParkinson(:, i))
    end
    
    
    %% z norm
    
    ImaParkinson_norm = zeros(520,29);
    for i = 1:size(ImaParkinson,1)
        for j = 1:size(ImaParkinson, 2)
            ImaParkinson_norm(i, j) = (ImaParkinson(i, j) - mean(ImaParkinson))/ std(ImaParkinson);
        end
    end
    
    NemaParkinson_norm = zeros(520,29);
    for i = 1:size(NemaParkinson,1)
        for j = 1:size(NemaParkinson, 2)
            NemaParkinson_norm(i, j) = (NemaParkinson(i, j) - mean(NemaParkinson))/ std(NemaParkinson);
        end
    end
    
    %% korelacija
    
    %figure, corrplot(ImaParkinson) matrica 29x29
    
    %ili
    kor_ImaParkinson = corr(ImaParkinson_norm);
    for i = 1:size(kor_ImaParkinson, 1)
        kor_ImaParkinson(i,i) = 0;
    end
    max_kor_ImaParkinson = max(max(kor_ImaParkinson));
    [m,n] = find(kor_ImaParkinson==max_kor_ImaParkinson);
    
    kor_NemaParkinson = corr(NemaParkinson_norm);
    for i = 1:size(kor_NemaParkinson, 1)
        kor_NemaParkinson(i,i) = 0;
    end
    max_kor_NemaParkinson = max(max(kor_NemaParkinson));
    [p,q] = find(kor_NemaParkinson==max_kor_NemaParkinson);

    
    
    %% scatter plot
    figure, scatter(ImaParkinson_norm(:,8),ImaParkinson_norm(:,11))
    lsline
    figure, scatter(NemaParkinson_norm(:,8),NemaParkinson_norm(:,11))
    lsline
    
    figure, scatter(ImaParkinson_norm(:,1),ImaParkinson_norm(:,3))
    lsline
    figure, scatter(NemaParkinson_norm(:,1),NemaParkinson_norm(:,3))
    lsline


    %% 19. atribut
    
    median_p = ImaParkinson(:, 19);
    median_n = NemaParkinson(:, 19);
    
    figure, subplot(1,2,1)
    boxplot(median_p)
    subplot(1,2,2)
    boxplot(median_n)
    
    %j = 0:0.01:100; 
    j = min(median_p):0.01:max(median_p); 
    b = min(median_n):0.01:max(median_n);
    
    norm_p=normpdf(j,mean(median_p),std(median_p));
    norm_n=normpdf(b,mean(median_n),std(median_n));
    figure, plot(j,norm_p,b,norm_n, 'LineWidth', 2)
    axis tight
    legend('Ima Parkinson', 'Nema Parkinson')

    
    
    
    
    

    
    