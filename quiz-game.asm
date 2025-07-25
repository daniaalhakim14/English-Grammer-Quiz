# t0 - to receive the user_input
# t1 - to hold the answer for every question
# t2 - to hold the marks of the user
# t3 - to hold the highest_score
# t4 - to hold the lowest_Score
# t5 - to hold the temporary number
# s0 - to hold the number of user's reattempt time
# s1 - to hold the adress of total_mark
# s2 - to hold the number 4
# s3 - to hold the multiplie number of s0 and s2
# s4 - to hold the counter
# s5 - to hold the condition number 0 or 1

.text
main:
#Before quiz
    #display greeting to user
    la $a0, out_title
    li $v0, 4
    syscall

    #display the requirement to user to enter his/her name
    la $a0, out_name
    syscall

    #let user enter his/her name
    la $a0, in_name
    li $a1, 20
    li $v0, 8
    syscall

#Quiz start and user need to answer question 1 until 10
Q1:
    la $a0, question_1
    li $v0, 4
    syscall
    la $a0, user_answer
    li $v0, 8
    syscall
    lb $t0, user_answer
    lb $t1, answer_a
    bne $t0, $t1, Q2
    addi $t2, $t2, 1

Q2:
    la $a0, question_2
    li $v0, 4
    syscall
    la $a0, user_answer
    li $v0, 8
    syscall
    lb $t0, user_answer
    lb $t1, answer_c
    bne $t0, $t1, Q3
    addi $t2, $t2, 1

Q3:
    la $a0, question_3
    li $v0, 4
    syscall
    la $a0, user_answer
    li $v0, 8
    syscall
    lb $t0, user_answer
    lb $t1, answer_a
    bne $t0, $t1, Q4
    addi $t2, $t2, 1

Q4:
    la $a0, question_4
    li $v0, 4
    syscall
    la $a0, user_answer
    li $v0, 8
    syscall
    lb $t0, user_answer
    lb $t1, answer_b
    bne $t0, $t1, Q5
    addi $t2, $t2, 1

Q5:
    la $a0, question_5
    li $v0, 4
    syscall
    la $a0, user_answer
    li $v0, 8
    syscall
    lb $t0, user_answer
    lb $t1, answer_a
    bne $t0, $t1, Q6
    addi $t2, $t2, 1

Q6:
    la $a0, question_6
    li $v0, 4
    syscall
    la $a0, user_answer
    li $v0, 8
    syscall
    lb $t0, user_answer
    lb $t1, answer_b
    bne $t0, $t1, Q7
    addi $t2, $t2, 1

Q7:
    la $a0, question_7
    li $v0, 4
    syscall
    la $a0, user_answer
    li $v0, 8
    syscall
    lb $t0, user_answer
    lb $t1, answer_a
    bne $t0, $t1, Q8
    addi $t2, $t2, 1

Q8:
    la $a0, question_8
    li $v0, 4
    syscall
    la $a0, user_answer
    li $v0, 8
    syscall
    lb $t0, user_answer
    lb $t1, answer_c
    bne $t0, $t1, Q9
    addi $t2, $t2, 1

Q9:
    la $a0, question_9
    li $v0, 4
    syscall
    la $a0, user_answer
    li $v0, 8
    syscall
    lb $t0, user_answer
    lb $t1, answer_b
    bne $t0, $t1, Q10
    addi $t2, $t2, 1

Q10:
    la $a0, question_10
    li $v0, 4
    syscall
    la $a0, user_answer
    li $v0, 8
    syscall
    lb $t0, user_answer
    lb $t1, answer_a
    bne $t0, $t1, Result
    addi $t2, $t2, 1

Result:
    #display user's name
    la $a0, Name
    li $v0, 4
    syscall
    la $a0, in_name
    li $v0, 4
    syscall
    
    #display user's total mark
    la $a0, Mark
    li $v0, 4
    syscall
    add $a0, $zero, $t2
    li $v0, 1
    syscall

# display user's performance according his/her mark
Performance:
    addi $t5, $0, 4
    blt $t2, $t5, Never_Give_Up
    addi $t5, $0, 9
    blt $t2, $t5, Good_Try
    j Well_Done

#if the user's total mark less than 4, this part will be executed
Never_Give_Up:
    la $a0, less_than_40
    li $v0, 4
    syscall
    j Key_in_mark

#if the user's total mark is between 4 and 8, this part will be executed
Good_Try:
    la $a0, between_40_80
    li $v0, 4
    syscall
    j Key_in_mark

#if the user's total mark is more than 8, this part will be executed
Well_Done:
    la $a0, more_than_80
    li $v0, 4
    syscall
    j Key_in_mark
#store the user's mark from the first attempt until the third reattempt to memory
Key_in_mark:
    la $s1, total_mark
    addi $s2, $0, 4
    mul $s3, $s0, $s2
    add $s1, $s1, $s3
    sw $t2, 0($s1)

#change and store the highest_score and lowest_score of the user
Score_Change:
    slti $s5, $s0, 1
    bne $s5, $0, default #if the reattempt time is 0, jump to default
    bgt $t2, $t3, Highest_Score_Change #if the mark is greater than the last highest_score, jump to Highest_Score_Change
    blt $t2, $t4, Lowest_Score_Change #if the mark is lower than the last lowest_scrore, jump to Lowest_Score_Change
    j Reattempt

#change the highest_score to the latest_mark
Highest_Score_Change:
    add $t3, $0, $t2
    j Reattempt

#change the lowest_score to the latest_mark
    Lowest_Score_Change:
    add $t4, $0, $t2
    j Reattempt

#set the default highest_score and lowest_Score to the latest_mark
default:
    add $t3, $0, $t2
    add $t4, $0, $t2

#display the sentences to ask the user weather he/she wants to reattempt the quiz
Reattempt:
    add $t2, $0, $0
    addi $s4, $0, 3
    beq $s0, $s4, End #if counter is equal to 3, it will jump to the end
    la $a0, out_asking_1
    li $v0, 4
    syscall
    add $a0, $zero, $s0
    li $v0, 1
    syscall
    la $a0, out_asking_2
    li $v0, 4
    syscall
    la $a0, out_asking_3
    li $v0, 4
    syscall
    la $a0, user_reply
    li $v0, 8
    syscall
    
# if user enter 'y', meeans that he/she wants to reattempt the quiz, else it will jump to the end
    lb $t0, user_reply
    lb $t1, yes
    beq $t0, $t1, Preparing
    j End

#if the user wants to reattempt, this preparing step will be executed
#every time user wants to reattempt the quiz, the counter will increase 1
#after that, user will start to reattempt the quiz
Preparing:
    addi $s0, $s0, 1
    j Q1

#display the highest_mark and lowest_mark of the user as well as the greetings for user who complete the quiz
End:
    la $a0, highest
    li $v0, 4
    syscall
    add $a0, $0, $t3
    li $v0, 1
    syscall
    la $a0, lowest
    li $v0, 4
    syscall
    add $a0, $0, $t4
    li $v0, 1
    syscall
    la $a0, Finish
    li $v0, 4
    syscall
Exit:
    li $v0, 10
    syscall
    
.data
out_title: .asciiz "Welcome To The English Grammar Quiz\n"
out_name: .asciiz "Please Enter Your Name: "
in_name: .space 80
total_mark: .word 0, 0, 0, 0
user_answer: .word 0
answer_a: .asciiz "a"
answer_b: .asciiz "b"
answer_c: .asciiz "c"
question_1: .asciiz "\n1. Neither Jane nor Tom ... busy at the moment.\na) is\tb) are\tc) am\n"
question_2: .asciiz "\n2. I ... never been to Mexico City before last October.\na) has\tb) have\tc) had\n"
question_3: .asciiz "\n3. My brother and I ... watching TV when the phone rang.\na) were\tb) are\tc) was\n"
question_4: .asciiz "\n4. I have an idea! Lets ... bowling this weekend!\na) do\tb) go\tc) play\n"
question_5: .asciiz "\n5. It is very important ... here on time for the meeting tomorrow.\na) to be\tb) are\tc) will be\n"
question_6: .asciiz "\n6. Traveling to a foreign country has ... its positive and negative points.\na) Neither\tb) both\tc) either\n"
question_7: .asciiz "\n7. Last week, we ... to the new Thai restaurant.\na) went\tb) had gone\tc) were going\n"
question_8: .asciiz "\n8. You ... have seen Jane at the Mall! She is in Canada right now.\na) shouldn't\tb) wouldn't\tc) couldn't\n"
question_9: .asciiz "\n9. ...you believe in magic?\na) Are\tb) Do\tc) Does\n"
question_10: .asciiz "\n10. If everyone did their part, the Earth ... a cleaner place\na) would be\tb) must be\tc) will be\n"
Name: .asciiz "\nPlayer Name: "
Mark: .asciiz "Total Marks: "
less_than_40: .asciiz "\nNever give up!"
between_40_80: .asciiz "\nGood try!"
more_than_80: .asciiz "\nWell done!"
out_asking_1: .asciiz "\n\nYour reattempt time is "
out_asking_2: .asciiz "\nYour maximum reattempt time is 3"
out_asking_3: .asciiz "\nDo you want to reattempt again? If yes please enter \'y\'\n"
user_reply: .word 0
yes: .asciiz "y"
Finish: .asciiz "\nCongratulation, you finish your quiz already"
highest: .asciiz "\n\nYour highest score is "
lowest: .asciiz "\nYour lowest score is "