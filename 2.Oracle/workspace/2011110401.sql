2021-1104-01)

  1) ���ڿ� ��
  . �Ǽ� �Ǵ� ������ �����ϴ� �ڷ���
  . NUMBER Ÿ�Ը� ������
  (�������)
  �÷��� NUMBER[(*|���е�[,������])]
  . '*|���е�' : ��ü �ڸ��� (1~30���� ����)
    '*'�� ����ϸ� �ý��ۿ��� �ڸ��� ������ ����
  . '������' : �Ҽ��� ������ �ڸ���
  . ǥ������ : 1.0 x E-130 ~9.9999... E+125(�Ҽ�������'9'�� ���� 38��)
  . �ڷ��� ����
     - �������� ����� ��� : �����Ϸ��� �ڷ��� �Ҽ������� (������ + 1) �ڸ����� �ݿø��Ͽ� (������) �ڸ��� ��ŭ ����.
     - �������� ������ ��� : �����κп��� (������) ��ġ�� ���� �κп��� �ݿø� (�����κ��� ������ ����)
     - 21.1234567    NUMBER (7,4) = 21.1235
     - 12345.6789    NUMBER (7,-1) = 12350
                     NUMBER (7,-2) = 12300
    -- DB������ �ִ��� Data�� ��Ȯ�� �����ؾ� �ϱ⿡, �ǵ��� ���� �ʴ� ���� ����. 
    -- (�ݿø� ���� �۾��� DB���� ���� Data�� Java��� �����ϸ� �ȴ�.)
    
    . ex)
    -----------------------------------------------------------------------------
    Ÿ�Լ���              ������                ����Ǵ� ��
    -----------------------------------------------------------------------------
    NUMBER              12345.9876            12345.9876
    NUMBER(*,3)         12345.9876            12345.988           --�ش� Data�� �����Ҷ��� ������ ��Ҹ� ã�� * = 8
    NUMBER(4)           12345.9876            ����(2345,9876)                 --���� �κ��� �ڸ����� �����ϸ� ����
    NUMBER(7,3)         12345.9876            ����(1234.9876)                 --���� �κ��� �ڸ����� �����ϸ� ����
    NUMBER(10,2)        12345.9876               12345.99         --���� �ڸ����� 8�̹Ƿ� 3���� ������ ����
    NUMBER(7,0)         12345.9876              123456            --���� �ڸ����� 7�̹Ƿ� 2���� ������ ����
    NUMBER(7)           12345.9876              123456            --���� �ڸ����� 7�̹Ƿ� 2���� ������ ����
    -----------------------------------------------------------------------------
    
��뿹)
    CREATE TABLE TEMP5(
    COL1 NUMBER,
    COL2 NUMBER(*,3),
    COL3 NUMBER(4),
    COL4 NUMBER(7,3),
    COL5 NUMBER(10,2),
    COL6 NUMBER(7,0),
    COL7 NUMBER(7)
    );
    
    INSERT INTO TEMP5
     VALUES(12345.9876,
            12345.9876,
            2345.9876,
            1234.9876,
            12345.9876,
            12345.9876,
            12345.9876);
     
     **���е� < ������
     . ���е��� '0'�� �ƴ� ��ȿ ������ ��
     . ������ : �Ҽ��� ������ �ڸ���
     . ������ - ���е� : �Ҽ��� ���Ͽ� �� ���� ���;� �� '0'�� ����
     ex)
     -------------------------------------------------------------------------
     �Է� ��             ����             ���Ǵ� ��
     -------------------------------------------------------------------------
     0.12345            NUMBER(3,5)     ����
     0.012345           NUMBER(4,5)     0.01235    
     0.0012345          NUMBER(3,5)     0.00123
     1.23               NUMBER(1,3)     ����
     0.012              NUMBER(2,5)     ����
     -------------------------------------------------------------------------
    
    
    
    
    
    
    
    
    
    
                     