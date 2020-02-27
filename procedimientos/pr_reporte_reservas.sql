CREATE OR REPLACE PROCEDURE PR_REPORTE_RESERVAS
AS
    CURSOR C_RESERVA_CLIENTE  IS
	SELECT R.K_RESERVA,C.K_NIT,C.N_NOMCLIENTE||' '||C.N_APECLIENTE N_NOMBRE,R.V_TOTAL,R.V_TOTAL*1.19 V_IVA
	FROM CLIENTE C,RESERVA R 
        WHERE R.K_NIT=C.K_NIT;
    L_SUMA NUMBER:=0;
    L_SUMAIVA NUMBER:=0;
BEGIN
    FOR RC_RESERVA_CLIENTE IN C_RESERVA_CLIENTE LOOP
	DBMS_OUTPUT.PUT_LINE(RPAD(RC_RESERVA_CLIENTE.K_RESERVA,10,' ')||' '||RPAD(RC_RESERVA_CLIENTE.K_NIT,10,' ')||' '||
                             RPAD(RC_RESERVA_CLIENTE.N_NOMBRE,20,' ')||' '||RPAD(TO_CHAR(RC_RESERVA_CLIENTE.V_TOTAL,'$9999999.99'),15,' ')||' '||
                             RPAD(TO_CHAR(RC_RESERVA_CLIENTE.V_IVA,'$9999999.99'),15,' '));
        L_SUMA:=L_SUMA+RC_RESERVA_CLIENTE.V_TOTAL;
        L_SUMAIVA:=L_SUMAIVA+RC_RESERVA_CLIENTE.V_IVA;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('TOTAL SIN IVA: '||TO_CHAR(L_SUMA,'$9999999.99'));
    DBMS_OUTPUT.PUT_LINE('TOTAL CON IVA: '||TO_CHAR(L_SUMAIVA,'$9999999.99'));
END PR_REPORTE_RESERVAS;
/

CREATE OR REPLACE PROCEDURE PR_LISTAR_CLIENTES(pref_clientes OUT SYS_REFCURSOR)
AS
BEGIN
    OPEN pref_clientes FOR
	SELECT N_NOMCLIENTE, N_APECLIENTE
	FROM CLIENTE;
END PR_LISTAR_CLIENTES;
/
