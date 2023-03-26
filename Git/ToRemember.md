



# Branch

- ### branch 생성 시, 생성하는 위치(commit) 에서 추가됨.

- ### add, commit 을 하지 않더라도 새로운 Unstaged file 의 경우 branch 이동 시 따라갈 수 있음;; 

<br><br><br>

# Git Commands

```git commit -a -m```  
수정된 것들은 포함되지만, 새로 생성된 file/directory 는 추가되지 않음.  
새로 생성되었을 경우 **```git add```** 먼저 해주고 commit 하기!

<br>

## branch 생성
```git branch <branch_name>```

<br>
## branch 이동
```git checkout <branch_name>```

``` git switch <branch_name>``` (newer)

<br>

## branch 생성 후 이동

```git checkout -b <branch_name>```  
```git switch -c <branch_name>```  
(_*_ b: branch, c: create)  
<br>

## branch 제거
```git branch -D <branch_name>```  
> **현재 위치해있는 branch는 제거할 수 없음.**