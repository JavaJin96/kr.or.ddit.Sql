2021-1102-02) SQL���
 - �˻���� (SELECT)
   ���������۾� (Data Manipulation Language (DML) : 
               INSERT, UPDATE, DELETE)
   ���������Ǿ� (Data Deinition Language (DDL) : CREATE, DROP, 
               ALTER)
   ����������� (Data Control Language (DCL) : GRANT, REVOKE, COMMIT, 
               rollback ��) - �������� �帧�� ����
               
               
1. �ڷ���
 - ����Ŭ���� ����ϴ� �ڷ������� ���ڿ�, ����, ��¥, 2���ڷ����� �����Ѵ�.
 
 1) ���ڿ� ��
 . ����Ŭ�� ���ڿ� �ڷ� Ÿ���� ��������Ÿ�԰� �������� Ÿ������ ����
 . CHAR, VARCHAR,VARCHAR2, NVARCHAR, LONG, CLOB, NCLOB ���� ����
 . ���ڿ� �ڷ�� '' �� ���� �ڷ�� ��ҹ��� ����
  (1)CHAR (n BYTE|CHAR)
  - �������� ���ڿ� ����
  - �ִ� 2000BYTE ���� ó�� ����
  - �ַ� �⺻Ű�� ���̰� ������ �׸�(�ֹε�Ϲ�ȣ ��)�� ���
  - ���ʺ��� ����ǰ� ���� ������ ������ ä����
  - 'BYTE|CHAR' : n�� ����Ʈ ������ ���ڼ�(CHAR) ���� ���� (�����ȴٸ�, default �� BYTE �� ����)
  - �ѱ� �ѱ��ڴ� 3BYTE �� ����Ѵ�. (���� CHAR(2000CHAR)�� ����ǵ� 666���ڸ� �ʰ��� �� ����. 
  
  ��뿹��)
  CREATE TABLE TMEP1(
   COL1 CHAR(20),
   COL2 CHAR(20 BYTE),
   COL3 CHAR(20 CHAR));
   
  INSERT INTO TEMP1
   VALUES('������ �߱�','������','������ �߱�');
   
  SELECT * FROM TEMP1;
  
  SELECT LENGTHB(COL1),
         LENGTHB(COL2),
         LENGTHB(COL3)
    FROM TEMP1;
   
 INSERT INTO TEMP1
   VALUES('������ �߱�','������','������ �߱� ���ﵿ');
   
   SELECT LENGTHB(COL1),
          LENGTHB(COL2),
          LENGTHB(COL3)
    FROM  TEMP1;
    
  (2)VARCHAR2 (n BYTE|CHAR)
  - �������� ������ ����
  - VARCHAR�� ���ϱ��
  - �ִ� 4000BYTE ���� ���� ����
  - ���� �θ� ���Ǵ� �ڷ�Ÿ��
  - NVARCHAR2 �ٱ��� ���� ������
  
  
��뿹) 

  CREATE TABLE TEMP2(
   COL1 VARCHAR (4000),
   COL2 VARCHAR2 (4000 BYTE),
   COL3 VARCHAR2 (4000 CHAR));
   
  INSERT INTO TEMP2 VALUES ('APPLE, PERSIMON, APPLE' , '���ѹα��� ���� ��ȭ���̴�.' , 'IL PSTINO');
  
  SELECT * FROM TEMP2;
  
  SELECT LENGTHB(COL1),
         LENGTHB(COL2),
         LENGTHB(COL3)
    FROM TEMP2;
    
    
  (3)LONG 
  - �������� ���ڿ� ����
  - �ִ�2GB���� ������ ����
  - �� ���̺� �ϳ��� �÷��� LONG Ÿ������ ���� ����(���ѻ���)
  - ��ɰ����� ����� (CLOB �� ��ü)
  - SELECT ���� SELECT��, INSERT���� VALUES��, UPDATE���� SET���� ��밡��
  - �Ϻ� ���ڿ� �Լ��� LONG Ÿ���� �÷��� ����� �� ����
  
��뿹)
   CREATE TABLE TEMP3(
     COL1 VARCHAR2(200),
     COL2 LONG,
     COL3 CLOB);
   
   INSERT INTO TEMP3 VALUES ('APPLE, PERSIMON, BANANA' , '���ѹα��� ���� ��ȭ���̴�.' , 'IL PSTINO');
   SELECT * FROM TEMP3;
   
   SELECT LENGTHB(COL1)
          /*LENGTHB(COL2),
          LENGTHB(COL3)*/
    FROM TEMP3;
   
   --CLOB Ÿ���� LENGTHB ���LENGTH(���ڼ�) �Լ��� �����.
   SELECT LENGTHB(COL1)
          LENGTH(COL2),
          LENGTH(COL3)
    FROM TEMP3;
    
  (4)CLOB (Character Large OBjects) 
  - �������� ������ ����
  - �ִ�4GB���� ������ ����
  - �� ���̺� �������� CLOB Ÿ�� ��� ����
  - �Ϻ� ��ɵ��� DBMS_LOB API ����� �޾ƾ� ��

--CLOB �� ��� �������� ������ BYTE�� �����ϰ� �ٽɸ� ����ϱ� ������ LENGTH �Լ��� ��밡�� �ϴ�.
��뿹)
   CREATE TABLE TEMP4(
    COL1 CLOB,
    COL2 CLOB,
    COL3 VARCHAR2(4000));
    
   INSERT INTO TEMP4 VALUES ('APPLE, PERSIMON, BANANA' , '���ѹα��� ���� ��ȭ���̴�.' , 'IL PSTINO');
   
   SELECT * FROM TEMP4;
   
   SELECT LENGTH(COL1),
          LENGTH(COL2),
          LENGTH(COL3);
          
          
   

    
    
   
   