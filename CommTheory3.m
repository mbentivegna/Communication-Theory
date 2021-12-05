%Michael Bentivegna
%Homework 3 - Communication Theory

clear;
clc;
close all;

%% Test 1
fprintf("Test Case 1: \n")
Experiment(2, 7, 3, 7, 10^5);

%% Test 2
fprintf("Test Case 2: \n")
Experiment(4, 5, 3, 7, 10^5);

%% Analyze arbitrary input data into proper output
function [redFromRed, redFromBlue, blueFromBlue, blueFromRed] = Experiment(R1, B1, R2, B2, N)

    %-------Summarize Parameters-------
    fprintf("R1 = %d, B1 = %d, R2 = %d, B2 = %d, N = %d\n\n", R1, B1, R2, B2, N)
    fprintf("Parameter Summary: \nR1 and B1 are the number of Red and Blue balls in Urn 1, respectively. After one ball\nis chosen it is placed in Urn 2 along with the R2 Red balls and B2 Blue balls. Lastly,\na ball from the second Urn is chosen and a guess for which ball was originally chosen\nfrom Urn 1 is made.  N is the number of times this experiment was repeated\n\n")
    
    %-------DECISION RULES-------
    %To Get ML decision maximize P(2nd Color / First Color)
    B2GivenB1_ML = (B2+1)/(B2+R2+1); 
    B2GivenR1_ML = (B2)/(B2+R2+1);
    
    R2GivenB1_ML = (R2)/(B2+R2+1); 
    R2GivenR1_ML = (R2+1)/(B2+R2+1);
    
    if B2GivenB1_ML > B2GivenR1_ML
        GuessSeenB_ML = "Blue";
    else
        GuessSeenB_ML = "Red";
    end

    if R2GivenB1_ML > R2GivenR1_ML
        GuessSeenR_ML = "Blue";
    else
        GuessSeenR_ML = "Red";
    end

    fprintf("For ML Model: Guess %s if Red and Guess %s if Blue \n", GuessSeenR_ML, GuessSeenB_ML)
    
    %To Get MAP decision maximize P(2nd Color / First Color) * P(First Color Being Picked)
    B1GivenB2_MAP = B2GivenB1_ML*(B1/(R1+B1));
    R1GivenB2_MAP = B2GivenR1_ML*(R1/(R1+B1));

    B1GivenR2_MAP = R2GivenB1_ML*(B1/(R1+B1));
    R1GivenR2_MAP = R2GivenR1_ML*(R1/(R1+B1)); 
    
    if B1GivenB2_MAP > R1GivenB2_MAP
        GuessSeenB_MAP = "Blue";
    else
        GuessSeenB_MAP = "Red";
    end

    if B1GivenR2_MAP > R1GivenR2_MAP
        GuessSeenR_MAP = "Blue";
    else
        GuessSeenR_MAP = "Red";
    end

    fprintf("For MAP Model: Guess %s if Red and Guess %s if Blue \n\n", GuessSeenR_MAP, GuessSeenB_MAP)
    
    %-------THEORETICAL ERROR-------
    %Theoretical Error ML (Can utilize rejected MAP values for each case)
    if GuessSeenR_ML == "Red" && GuessSeenB_ML == "Red"
        T_Error_ML = B1GivenR2_MAP + B1GivenB2_MAP;
        
    elseif GuessSeenR_ML == "Blue" && GuessSeenB_ML == "Red"
        T_Error_ML = R1GivenR2_MAP + B1GivenB2_MAP;
        
    elseif GuessSeenR_ML == "Blue" && GuessSeenB_ML == "Blue"
        T_Error_ML = R1GivenR2_MAP + R1GivenB2_MAP;
        
    else     
        T_Error_ML = B1GivenR2_MAP + R1GivenB2_MAP;
    end
    
    %Theoretical Error MAP
    if GuessSeenR_MAP == "Red" && GuessSeenB_MAP == "Red"
        T_Error_MAP = B1GivenR2_MAP + B1GivenB2_MAP;
        
    elseif GuessSeenR_MAP == "Blue" && GuessSeenB_MAP == "Red"
        T_Error_MAP = R1GivenR2_MAP + B1GivenB2_MAP;
        
    elseif GuessSeenR_MAP == "Blue" && GuessSeenB_MAP == "Blue"
        T_Error_MAP = R1GivenR2_MAP + R1GivenB2_MAP;
        
    else     
        T_Error_MAP = B1GivenR2_MAP + R1GivenB2_MAP;
    end
    
    fprintf("Theoretical Error for ML: %f \n", T_Error_ML)
    fprintf("Theoretical Error for MAP: %f \n\n", T_Error_MAP)
    
    %-------SIMULATE EXPERIMENT-------
    blueFromBlue = 0;
    redFromBlue = 0;
    blueFromRed = 0;
    redFromRed = 0;
    
    for i = 1:N
        x = randi([1,R1+B1]);
        y = randi([1,R2+B2+1]);
        if x > R1  
            if y > R2
                blueFromBlue = blueFromBlue + 1;
            else
                redFromBlue = redFromBlue + 1;
            end
        else 
            if y > R2 + 1
                blueFromRed = blueFromRed + 1;
            else
               redFromRed = redFromRed + 1;
            end
        end
    end
    
    %-------ESTIMATED ERROR-------
    %Estimated Probability of Error ML
    if GuessSeenR_ML == "Red" && GuessSeenB_ML == "Red"
        Error_ML = (redFromBlue + blueFromBlue)/N;
        
    elseif GuessSeenR_ML == "Blue" && GuessSeenB_ML == "Red"
        Error_ML = (redFromRed + blueFromBlue)/N;
        
    elseif GuessSeenR_ML == "Blue" && GuessSeenB_ML == "Blue"
        Error_ML = (redFromRed + blueFromRed)/N;
        
    else     
        Error_ML = (redFromBlue + blueFromRed)/N;
    end
    
    %Estimated Probability of Error MAP
    if GuessSeenR_MAP == "Red" && GuessSeenB_MAP == "Red"
        Error_MAP = (redFromBlue + blueFromBlue)/N;
        
    elseif GuessSeenR_MAP == "Blue" && GuessSeenB_MAP == "Red"
        Error_MAP = (redFromRed + blueFromBlue)/N;
        
    elseif GuessSeenR_MAP == "Blue" && GuessSeenB_MAP == "Blue"
        Error_MAP = (redFromRed + blueFromRed)/N;
        
    else
        Error_MAP = (redFromBlue + blueFromRed)/N;     
    end
    
    fprintf("The Estimated ML error is: %f \n", Error_ML)
    fprintf("The Estimated MAP error is: %f\n\n", Error_MAP)
    
end