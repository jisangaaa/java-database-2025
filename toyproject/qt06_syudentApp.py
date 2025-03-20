#Oracle student앱
#CRUD 데이터베이스 DML(SELECT,INSERT,UPDATE,DELETE)
## CREATE(INSERT), REQUEST(SELECT), UPDATE(UPDATE), DELETE(DELETE)
import sys
from PyQt5.QtWidgets import *
from PyQt5.QtGui import *
from PyQt5 import QtWidgets,QtGui,uic

#오라클 모듈
import cx_Oracle as oci

#DB 연결 설정
sid = 'XE'
host = 'localhost'
port = 1521
username = 'madang'
password = 'madang'

class MainWindow(QMainWindow):
    def __init__(self):
        super(MainWindow, self).__init__()
        self.initUI()
        self.loadData()

    def initUI(self):
        uic.loadUi('./toyproject/studentdb.ui', self)
        self.setWindowTitle('학생정보앱')
        # self.setWindowIcon(QIcon('./image/'))

        #버튼 이벤트 추가
        self.btn_add.clicked.connect(self.btnAddclick)
        self.btn_mod.clicked.connect(self.btnModclick)
        self.btn_del.clicked.connect(self.btnDelclick)
        self.show()

    def btnAddclick(self):
        #print('추가버튼 클릭')
        std_name = self.input_std_name.text()
        std_mobile = self.input_std_mobile.text()
        std_regyear = self.input_std_regyear.text()
        print(std_name,std_mobile,std_regyear)

        #입력검증 필수(Validation Check)
        if std_name == '' or std_regyear == '':
            QMessageBox.warning(self,'경고','학생이름 또는 입학년도는 필수입니다')
            return
        else :
            print('DB입력 진행')
            values = (std_name, std_mobile, std_regyear)
            self.addData(values)

    def btnModclick(self):
        print('수정버튼 클릭')

    def btnDelclick(self):
        print('삭제버튼 클릭')

    #테이블위젯 데이터와 연관해서 화면 설정
    def makeTable(self,cursor):
        self.tblstudent.setColumnCount(4)
        self.tblstudent.setRowCount(cursor.prefetchrows) #커서에 들어있는 데이터 길이만큼 row를 생성
        self.tblstudent.setHorizontalHeaderLabels(['학생번호','학생이름','핸드폰','입학년도'])

        # 전달받은 커서를 반복문으로 테이블위젯에 뿌리는 작업
        i = 0
        for _, (std_id, std_name, std_mobile, std_regyear) in enumerate(cursor, start=1):
            self.tblstudent.setItem(i,0,QTableWidgetItem(str(std_id)))
            self.tblstudent.setItem(i,1,QTableWidgetItem(std_name))
            self.tblstudent.setItem(i,2,QTableWidgetItem(std_mobile))
            self.tblstudent.setItem(i,3,QTableWidgetItem(str(std_regyear)))
            i += 1

    ## R(SELECT)
    def loadData(self):
        #DB연결
        conn = oci.connect(f'{username}/{password}@{host}:{port}/{sid}')
        cursor = conn.cursor()

        query = 'SELECT * FROM Students'
        cursor.execute(query)

        # for i, item in enumerate(cursor, start=1):
        #     print(item)  
        self.makeTable(cursor)

        cursor.close()
        conn.close()

    def addData(self, tuples):
        conn = oci.connect(f'{username}/{password}@{host}:{port}/{sid}')
        cursor = conn.cursor()

        try:
            conn.begin()

            query = '''
                    INSERT INTO MADANG.STUDENTS (std_id, std_name, std_mobile, std_regyear)
                    VALUES(SEQ_STUDENT.NEXTVAL, :v_std_name, :v_std_mobile, :v_std_regyear)
                    '''
            cursor.execute(query, tuples)

            conn.commit()
            last_id = cursor.lastrowid
            print(last_id)
            #return True
        except Exception as e:
            print(e)
            conn.rollback()
        finally:
            cursor.close()
            conn.close()


if __name__ == '__main__':
    app=QApplication(sys.argv)
    win=MainWindow()
    app.exec_()
