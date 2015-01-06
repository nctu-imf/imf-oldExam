#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <pthread.h> //lib for pthread
#include <fstream>
#include <semaphore.h> //lib for semaphore
using namespace std;
string input[4]={"testdata1.txt","testdata2.txt","testdata3.txt","testdata4.txt"};
sem_t sem[4]; //semaphores for the four thread
sem_t total_sem; //semaphore for the summing thread
sem_t file_sem; //semaphore for the global varible writing
long long final_sum=0;
int flag=1;

void *sumup(void *threadid){ //function for sum up before wait
    int *id_ptr,taskid;
    long long sum=0;
    id_ptr=(int*)threadid;
    taskid=*id_ptr;
    fstream file;
    file.open(input[taskid]);
    if(file){
        string tmp;
        while(getline(file,tmp)){
            if(tmp=="wait" || tmp=="wait\r"){
                sem_wait(&file_sem); //only one can write the global var at a time
                final_sum+=sum; //critical section for writing global var
                sem_post(&file_sem); //I am done
                sum=0; //set local sum to zero
                sem_post(&total_sem); //I am done,total_sem you may go when you got 4
                sem_wait(&sem[taskid]); //I should wait for other threads and the total summing thread
            }else{
                sum+=atoi(tmp.c_str());
            }
        }
    }else cout<<"file open error"<<endl;
    flag=0;
    pthread_exit((void *)0);
}
void *total(void*){
    int sem_value=0,count=1;
    fstream file;
    file.open("Result.txt",ios::out);
    while(flag){
        sem_getvalue(&total_sem,&sem_value);
        if(sem_value==4){ //local summing is done,write the file!
            file<<"No. "<<count<<" output : "<<final_sum<<endl;
            count++;
            final_sum=0;
            for(int i=0;i<4;i++){
                sem_post(&sem[i]); //the 4 threads ready to go
                sem_wait(&total_sem); //I should wait for them
            }
        }
    }
    file.close();
    pthread_exit((void *)0);
}
int main()
{
    pthread_t threads[4]; //pthread for the 4 threads
    pthread_t file_thread; //pthread for the file writing thread
    void *status;
    int taskids[4]={0,1,2,3};
    int rc; //error recorder
    for(int i=0;i<4;i++){
        sem_init(&sem[i], 0, 0); //init the semaphores to 0
    }
    sem_init(&total_sem,0, 0);
    sem_init(&file_sem,0, 1); //only one can write the file
    for(int t=0;t<4;t++){
        rc = pthread_create(&threads[t], NULL, sumup, taskids+t);
        if (rc){
            printf("ERROR; return code from pthread_create() is %d\n", rc);
        }
    }
    pthread_create(&file_thread,NULL, total, NULL);
    pthread_exit((void *)0);
    for(int i=0;i<4;i++) sem_destroy(&sem[i]); //destroy semaphores
    sem_destroy(&file_sem);
    sem_destroy(&total_sem);
    return 0;
}