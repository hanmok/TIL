# 선언(declaration), 정의(definition), 초기화(initialization)

## 선언 vs 정의  
메모리를 할당하는가?  
할당하지 않고 이름만 알려준다면 선언,  
메모리가 할당된다면 정의. 
<br>
<br>
여러번 선언할 수 있으나, 여러번 정의할 수는 없음.
대부분의 경우, 정의가 선언이 됨.  
변수는 선언과 동시에 정의되는 경우가 많으며, 크게 '선언'과 '정의' 를 구분지어 얘기하지 않음.

<br>
<br>

## 정의 (Definition)
What you needd when executing the program(address + space for that, + Declaration)
(Including Declaration of the variable)
이름으로 class, function, variable 등을 **식별**. 
variable 을 정의할 때, 여러 bytes 의 메모리를 가지게 됨. 
<br>
<br>

## 선언 (Declaration)
What you need when using the variable. (name, type)  
class, namespace, function, variable 등에 이름을 지어줄 때 사용. 
선언 없이 프로그램 내에서 이름을 사용하면 안됨.
정의와는 다르게, 쉽게 여러 elements 를 여러번 선언할 수 있음.
그러나, 여러번 선언할 경우 동일한 format 을 사용해야만 함. 
<br>
<br>

## 초기화(initialization)
선언과 동시에 값을 저장하는 과정
<br>
<br>


|Parameters|Definition|Declaration||
|:---:|:---|:---|---|
|Basics|It aims at determining the overall values stored in a class, a function, or a variable|It aims at specifying the name of any given class, function, variable, etc|
|Allocation of Memory|Definition allocates memory to an entity|A declaration does not allocate memory to the entities|
|Repetition|Once you define an entity, you cannot keep repeating the definition process again and again |Even if you declare an entity, the process of redeclaration can always be possible at any given instance|
|Scope|it is determined|It has well-defined visibility|


<br>
<br>

```c
extern int x; // declare only. (doesn't have address), Error message: variable x is 'undefined'
extern int x;
extern int x;

void main() 
{
	int a; 	//변수의 선언과 동시에 정의
	int b = 10; // 동일, 초기화도 되어있음.
}

int x; // declare again in the same file, prevent error
```

<br><br>

출처  
https://byjus.com/gate/difference-between-definition-and-declaration/  
https://www.youtube.com/watch?v=TtJw4VUYsiM