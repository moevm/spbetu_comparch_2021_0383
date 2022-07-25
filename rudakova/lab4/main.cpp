#include <iostream>

using namespace std;

char input[81];
int num = -1; //�������-����� ����� � ��������
int arr[26] = { 0 }; //������ ������� ������� ������� ��������� ����� ���������� �������� �� ������� ������
int len;

int main() {
    system("chcp 1251 > nul");
    setlocale(LC_CTYPE, "rus");
    cout << "�����: �������� ���� ��.��.0383 \n������������ ������ ��������� ��������� ����� �� �������� � ������ ������� ��� ������� ��������� �� ������� ������ � ������ �� �� �����.\n������� ������: ";

    cin.getline(input, 81);  //������� ������
    len = strlen(input);     //����� ������� ������
    __asm {
        push ds
        pop es

        mov al, 'a'
        dec al
        cycle ://������� ���� ��������
        mov edi, offset input     //������������� � edi �������� �� ������� ������
            mov ecx, len
            cmp al, 'Z'
            je label
            inc al
            label ://����� � ������
        inc num
            repne scasb        //������������ ����� �� ������� ������, �� ���������� ����� ���������� ���, ������� �� ������� ������ ��������
            has_symbol_check ://�������� �������
        cmp ecx, 0
            jne get_index    //���� ������ ����������
            dec edi
            cmp ES : [edi] , al //�������� ����� ��������� ������ � ���� �������
            je get_index
            jmp last_iteration_check
            get_index ://���� ������ ����������
        mov ebx, len
            sub ebx, ecx //ebx ������ �������� ������ ������� ���������
            mov esi, num
            mov ES : arr[esi * 4], ebx   //�������� � ������ ������ ������� ���������
            jmp last_iteration_check
            last_iteration_check ://����� �������� ���������� ������� ��������
        cmp al, 'z'
            je the_end
            jne cycle

            the_end :
    };
    int flag = 0;
    for (int i = 0; i < 26; i++) {
        if (arr[i] != 0) {
            cout << i + 1 << ' ' << arr[i] << endl;
            flag = 1;
        }
    }
    if (flag == 0)
        cout << "����� ���������� �������� ����������� � ��������� ������.";
    return 0;
}