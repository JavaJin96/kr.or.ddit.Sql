2021-1102-01) ����� ���

1) ���� ����(����� ����)
 - ����Ŭ ����ڰ��� ����
 - ����Ŭ ����ڴ� ��ü(object)�� ���
 (�������)
 CREATE USER ������ IDENTIFIED BY ��ȣ;
 
 CREATE USER PSJ96 IDENTIFIED BY java;
 
 2)���Ѻο�
  - ������ ������� ���� ���� ����
  (�������)
  GRANT ���Ѹ�1[,���Ѹ�2,...] TO ������;
  
  GRANT CONNECT,RESOURCE,DBA TO PSJ96;
  
 3)HR ���� Ȱ��ȭ
  - HR������ ��� ���¸� Ȱ��ȭ ���·� ����
  (�������)
  ALTER USER ������ ACCOUNT UNLOCK;
  - ������ HR ������ ���
  ALTER USER HR ACCOUNT UNLOCk;
  
  - ��ȣ����
  ALTER USER ������ IDENTIFIED BY ��ȣ;
  
  ALTER USER HR IDENTIFIED BY java;