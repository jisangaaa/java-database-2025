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
basic_msg = '학생정보 v1.0'

class MainWindow(QMainWindow):
    def __init__(self):
        super(MainWindow, self).__init__()
        self.initUI()
        self.loadData()

    def initUI(self):
        uic.loadUi('./toyproject/studentdb.ui', self)
        self.setWindowTitle('학생정보앱')
        self.setWindowIcon(QIcon('./image/students.png'))

        # 상태바에 메시지 추가
        self.statusbar.showMessage(basic_msg)

        # 버튼 아이콘 추가
        self.btn_add.setIcon(QIcon('./image/add-user.png'))
        self.btn_mod.setIcon(QIcon('./image/edit-user.png'))
        self.btn_del.setIcon(QIcon('./image/del-user.png'))

        #버튼 이벤트 추가
        self.btn_add.clicked.connect(self.btnAddclick)
        self.btn_mod.clicked.connect(self.btnModclick)
        self.btn_del.clicked.connect(self.btnDelclick)
        self.show()

    def clearInput(self):
        self.input_std_name.clear()
        self.input_std_mobile.clear()
        self.input_std_regyear.clear()

    def tblStudentDoubleClick(Self):
        #QMessageBox.about(self,'더블클릭','동작합니다')
        selected = self.tblStudent.currentRow() #현재 선택된 row값을 반환함수
        std_id = self.tblStudent.item(select,0).text()
        std_name = self.tblStudent.item(select,1).text()
        std_mobile = self.tblStudent.item(select,2).text()
        std_regyear = self.tblStudent.item(select,3).text()
        #QMessageBox.about(self,'더블클릭',f'{std_id},{std_name},{std_mobile},{std_regyear}')

        self.input_std_id.setText(std_id)
        self.input_std_name.setText(std_name)
        self.input_std_mobile.setText(std_mobile)
        self.input_std_regyear.setText(std_regyear)

    # 추가버튼 클릭 시그널처리 함수
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

            self.loadData() #다시 테이블위젯 데이터를 DB에서 조회.

            self.clearInput()  #input값 삭제함수 호출

    #수정버튼 클릭 시그널처리 함수
    def btnModclick(self):
        #print('수정버튼 클릭')
        std_id = self.input_std_id.text()
        std_name = self.input_std_name.text()
        std_mobile = self.input_std_mobile.text()
        std_reayear = self.input_std_reayear.text()
        #print(std_name,std_mobile,std_regyear,std_id)

        if std_id == '' or std_name == '' or std_regyear == '':
            QMessageBox.warning(self,'경고','학생번호,학생이름 또는 입학년도는 필수입니다')
            return
        else:
            print('DB수정')
            values = (std_name, std_mobile,std_regyear, std_id)
            if self.modData(values) == True:
                QMessageBox.about(self, '수정성공', '학생정보 수정성공')
            else:
                QMessageBox.about(self,'수정실패','관리자에게 문의하세요')

            self.loadData()
            self.clearInput()


    def btnDelclick(self):
        #print('삭제버튼 클릭')
        std_id = self.input_std_id.text()

        if std_id == '':
            QMessageBox.warning(self,'경고','학생번호는 필수입니다')
            return
        else:
            print('DB삭제 진행')
            # Oracle은 파라미터 타입에 민감. 정확한 타입을 사용해야 함.
            values = (std_id)
            if self.delData(values) == True:
                QMessageBox.about(self, '삭제성공', '학생정보 삭제성공')
            else:
                QMessageBox.about(self,'삭제실패','관리자에게 문의하세요')

            self.loadData()
            self.clearInput()

            self.statusbar.showMessage(f'{basic_msg} | 삭제완료')

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
