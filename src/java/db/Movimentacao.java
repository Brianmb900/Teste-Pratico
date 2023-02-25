/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package db;

import java.sql.*;
import java.util.ArrayList;
import web.DatabaseListener;

/**
 *
 * @author user
 */
public class Movimentacao {
    
    private Integer idenMov;
    private Integer idenCon;
    private String movimentacao;
    private String dtIni;
    private String dtFim;
    private String hrIni;
    private String hrFim;
    
    public static String getMovimentacaoCreateStatement() {
        return "CREATE TABLE IF NOT EXISTS movimentacao("
                + "id_movimentacao INTEGER PRIMARY KEY AUTOINCREMENT,"
                + "id_container INTEGER,"
                + "nm_movimentacao VARCHAR NOT NULL,"
                + "dt_inicio VARCHAR NOT NULL,"
                + "dt_fim VARCHAR NOT NULL,"
                + "hr_inicio VARCHAR NOT NULL,"
                + "hr_fim VARCHAR NOT NULL,"
                + "FOREIGN KEY (id_container) REFERENCES container (id_container))";
    }
    
    public static ArrayList<Movimentacao> getMovimentacoes() throws Exception {
        ArrayList<Movimentacao> list = new ArrayList<>();
        Connection con = DatabaseListener.getConnection();
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM movimentacao ORDER BY id_movimentacao");
        while (rs.next()) {
            Integer idenMov = rs.getInt("id_movimentacao");
            Integer idenCon = rs.getInt("id_container");
            String movimentacao = rs.getString("nm_movimentacao");
            String dtInicio = rs.getString("dt_inicio");
            String dtFim = rs.getString("dt_fim");
            String hrInicio = rs.getString("hr_inicio");
            String hrFim = rs.getString("hr_fim");
            list.add(new Movimentacao(idenMov, idenCon, movimentacao, dtInicio, dtFim, hrInicio, hrFim));
        }
        stmt.close();
        con.close();
        return list;
    }
    
    public static void addMovimentacao(Movimentacao movimentacao) throws Exception {
        Connection con = DatabaseListener.getConnection();
        PreparedStatement stmt = con.prepareStatement("INSERT INTO movimentacao(id_container, nm_movimentacao, dt_inicio, dt_fim, hr_inicio, hr_fim)"
                + "VALUES (?,?,?,?,?,?)");
        stmt.setInt(1, movimentacao.getIdenCon());
        stmt.setString(2, movimentacao.getMovimentacao());
        stmt.setString(3, movimentacao.getDtIni());
        stmt.setString(4, movimentacao.getDtFim());
        stmt.setString(5, movimentacao.getHrIni());
        stmt.setString(6, movimentacao.getHrFim());
        stmt.execute();
        stmt.close();
        con.close();
    }
    
    public static void alterarMovimentacao(Integer idenCon, String movimentacao, String dtIni, String dtFim, String hrIni, String hrFim, Integer idenMov) throws Exception {
        Connection con = DatabaseListener.getConnection();
        PreparedStatement stmt = con.prepareStatement(""
                + "UPDATE movimentacao SET id_container = ?, nm_movimentacao = ?, dt_inicio = ?, dt_fim = ?, hr_inicio = ?, hr_fim = ? WHERE id_movimentacao = ?");
        stmt.setInt(1, idenCon);
        stmt.setString(2, movimentacao);
        stmt.setString(3, dtIni);
        stmt.setString(4, dtFim);
        stmt.setString(5, hrIni);
        stmt.setString(6, hrFim);
        stmt.setInt(7, idenMov);
        stmt.execute();
        stmt.close();
        con.close();
    }
    
    public static void deleteMovimentacao(Integer idenMov) throws Exception {
        Connection con = DatabaseListener.getConnection();
        PreparedStatement stmt = con.prepareStatement("DELETE FROM movimentacao WHERE id_movimentacao = ?");
        stmt.setInt(1, idenMov);
        stmt.execute();
        stmt.close();
        con.close();
    }
    
    public String getNomeCliente() throws Exception {
        Connection con = DatabaseListener.getConnection();
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT nm_cliente FROM container WHERE id_container =" + getIdenCon() + "");
        String cliente = rs.getString("nm_cliente");
        stmt.close();
        con.close();
        return cliente;
    }
    
    public Movimentacao(Integer idenMov, Integer idenCon, String movimentacao, String dtIni, String dtFim, String hrIni, String hrFim) {
        this.idenMov = idenMov;
        this.idenCon = idenCon;
        this.movimentacao = movimentacao;
        this.dtIni = dtIni;
        this.dtFim = dtFim;
        this.hrIni = hrIni;
        this.hrFim = hrFim;
    }
    
    public Integer getIdenMov() {
        return idenMov;
    }
    
    public void setIdenMov(Integer idenMov) {
        this.idenMov = idenMov;
    }
    
    public Integer getIdenCon() {
        return idenCon;
    }
    
    public void setIdenCon(Integer idenCon) {
        this.idenCon = idenCon;
    }
    
    public String getMovimentacao() {
        return movimentacao;
    }
    
    public void setMovimentacao(String movimentacao) {
        this.movimentacao = movimentacao;
    }
    
    public String getDtIni() {
        return dtIni;
    }
    
    public void setDtIni(String dtIni) {
        this.dtIni = dtIni;
    }
    
    public String getDtFim() {
        return dtFim;
    }
    
    public void setDtFim(String dtFim) {
        this.dtFim = dtFim;
    }
    
    public String getHrIni() {
        return hrIni;
    }
    
    public void setHrIni(String hrIni) {
        this.hrIni = hrIni;
    }
    
    public String getHrFim() {
        return hrFim;
    }
    
    public void setHrFim(String hrFim) {
        this.hrFim = hrFim;
    }
    
}
