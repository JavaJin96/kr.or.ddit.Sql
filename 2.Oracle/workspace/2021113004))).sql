2021-1130-04)�ݺ����� Ŀ��
 1) �ݺ��� 
  - ���α׷��־���� �ݺ����� ��Ȱ�� ����
  - LOOP,WHILE,FOR�� ����
  1) LOOP ��
   -���ѷ��� ����
   -�ݺ����� �⺻���� ����

    (�������)
     LOOP
        �ݺ���ɹ�(��)��
        [EXIT THEN ����;]
     END LOOP;
      - 'EXIT WHEN ����' : ������ ���� ��� �ݺ��� ���
      
��뿹) �������� 7���� ����Ͻÿ�.
    DECLARE 
      V_CNT NUMBER:=1;
      V_SUM NUMBER:=0;
    BEGIN
     LOOP
       V_SUM:=7*V_CNT;
       EXIT WHEN V_CNT>9;
       DBMS_OUTPUT.PUT_LINE(7||'*'||V_CNT||'='||V_SUM);
       V_CNT:=V_CNT+1;
       END LOOP;
    END;
    
    ��뿹2_ ������� �����Ͽ� ���� 2���� ���� �����Ҷ� ���� �Ŀ� 100������ �Ǵ��� ����Ͻÿ�.
    DECLARE
     V_SUM NUMBER :=100;
     V_CNTDAY NUMBER :=0;
    BEGIN
     LOOP
        EXIT WHEN V_SUM >=1000000;
        V_SUM:=V_SUM*2;
        V_CNTDAY:=V_CNTDAY+1;
     END LOOP;
     DBMS_OUTPUT.PUT_LINE('100���� ������ ���� �ɸ���¥: '||V_CNTDAY||'��');
     DBMS_OUTPUT.PUT_LINE('������ ��: '||V_SUM||'��');
    END;
 
 2) WHILE �ݺ��� 
  . CURSOR���� Ȥ�� FOR���� �������� ��ȿ�� ���̶� �� �Ⱦ���.
  . �����Ǵ� �� �ݺ� ����
  . �ݺ�Ƚ���� �߿����� �ʰų� Ƚ���� ���� ���Ҷ�
  . �ݺ��� ����� Ż�������� �˰� ������
    (�������)
    WHILE ���� LOOP
      �ݺ�ó����(��);
      
      
    END LOOP;
     - ������ ���̸� �ݺ�����, �����̸� �ݺ��� ������
     
     ��뿹1_�� �������� WHILE ������ �����Ͻÿ�.
     
     DECLARE 
      V_CNT NUMBER :=1;
      V_SUM NUMBER :=0;
     BEGIN
        WHILE (V_CNT<9) LOOP
        V_SUM:= 7*V_CNT;
        DBMS_OUTPUT.PUT_LINE('7*'||V_CNT||'='||V_SUM);
        V_CNT:=V_CNT+1;
        END LOOP;
     END;
     
     --�ι�° ���� WHILE ������:
  
  2) FOR ��
   . Ŀ���� FOR���� �Ϲ� FOR���� �����ִ�. 
   . �ݺ�Ƚ���� �߿��ϰų� �ݺ�Ƚ���� ��Ȯ�� �˰��ִ� ���
    
    2-1(�Ϲ��� FOR���� �������)
     FOR �ε��� IN [REVERSE] �ʱⰪ..������ LOOP
      �ݺ�ó����ɹ�(��);
     END LOOP;
     . �ε��� : �ʱⰪ���� �������� ������ �������� �ý��ۿ��� Ȯ������
     . �ʱⰪ..������ : �ʱⰪ���� ���������� 1�� ����
     
     ��뿹1) 
     �������� 7��
     DECLARE 
       V_SUM NUMBER:=0;
     BEGIN
       FOR I IN 1..9 LOOP
         V_SUM:=7*I;
         DBMS_OUTPUT.PUT_LINE('7*'||I||'='||V_SUM);
       END LOOP;
     END;
     
   2-2(Ŀ���� FOR���� �������)
      FOR ���ڵ� IN Ŀ���̸�|Ŀ���� SELECT�� LOOP
        ó����ɹ�(��);
      END LOOP;
      .Ŀ���÷� ������ '���ڵ�.Ŀ���÷���'
    