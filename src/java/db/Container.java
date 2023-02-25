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
public class Container {

    private Integer identificacao;
    private String nomeCliente;
    private String codContainer;
    private int tipo;
    private String status;
    private String categoria;

    public static String getContainerCreateStatement() {
        return "CREATE TABLE IF NOT EXISTS container("
                + "id_container INTEGER PRIMARY KEY AUTOINCREMENT,"
                + "nm_cliente VARCHAR NOT NULL,"
                + "cd_container VARCHAR NOT NULL,"
                + "ic_tipo_vinte_quarenta INTEGER NOT NULL,"
                + "ic_status_cheio_vazio VARCHAR NOT NULL,"
                + "ic_categoria_importacao_exportacao VARCHAR NOT NULL)";
    }

    public static ArrayList<Container> getContainer() throws Exception {
        ArrayList<Container> list = new ArrayList<>();
        Connection con = DatabaseListener.getConnection();
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM container ORDER BY id_container");
        while (rs.next()) {
            Integer identificacao = rs.getInt("id_container");
            String nomeCliente = rs.getString("nm_cliente");
            String codContainer = rs.getString("cd_container");
            Integer tipo = rs.getInt("ic_tipo_vinte_quarenta");
            String status = rs.getString("ic_status_cheio_vazio");
            String categoria = rs.getString("ic_categoria_importacao_exportacao");
            list.add(new Container(identificacao, nomeCliente, codContainer, tipo, status, categoria));
        }
        stmt.close();
        con.close();
        return list;
    }

    public static void addContainer(Container container) throws Exception {
        Connection con = DatabaseListener.getConnection();
        PreparedStatement stmt = con.prepareStatement("INSERT INTO container(nm_cliente, cd_container, ic_tipo_vinte_quarenta, ic_status_cheio_vazio, ic_categoria_importacao_exportacao)"
                + "VALUES (?,?,?,?,?)");
        stmt.setString(1, container.getNomeCliente());
        stmt.setString(2, container.getCodContainer());
        stmt.setInt(3, container.getTipo());
        stmt.setString(4, container.getStatus());
        stmt.setString(5, container.getCategoria());
        stmt.execute();
        stmt.close();
        con.close();
    }
    
    public static void alterarContainer(String nomeCliente, String codigo, int tipo, String status, String categoria, Integer identificacao) throws Exception{
        Connection con = DatabaseListener.getConnection();
        PreparedStatement stmt = con.prepareStatement(""
                + "UPDATE container SET nm_cliente = ?, cd_container = ?, ic_tipo_vinte_quarenta = ?, ic_status_cheio_vazio = ?, ic_categoria_importacao_exportacao = ? WHERE id_container = ?");
        stmt.setString(1, nomeCliente);
        stmt.setString(2, codigo);
        stmt.setInt(3, tipo);
        stmt.setString(4, status);
        stmt.setString(5, categoria);
        stmt.setInt(6, identificacao);
        stmt.execute();
        stmt.close();
        con.close();
    }
    
    public static void deleteContainer(Integer identificacao) throws Exception{
        Connection con = DatabaseListener.getConnection();
        PreparedStatement stmt = con.prepareStatement("DELETE FROM container WHERE id_container = ?");
        stmt.setInt(1, identificacao);
        stmt.execute();
        stmt.close();
        con.close();
    }

    public Container(Integer identificacao, String nomeCliente, String codContainer, int tipo, String status, String categoria) {
        this.identificacao = identificacao;
        this.nomeCliente = nomeCliente;
        this.codContainer = codContainer;
        this.tipo = tipo;
        this.status = status;
        this.categoria = categoria;
    }

    public Integer getIdentificacao() {
        return identificacao;
    }

    public void setIdentificacao(Integer identificacao) {
        this.identificacao = identificacao;
    }

    public String getNomeCliente() {
        return nomeCliente;
    }

    public void setNomeCliente(String nomeCliente) {
        this.nomeCliente = nomeCliente;
    }

    public String getCodContainer() {
        return codContainer;
    }

    public void setCodContainer(String codContainer) {
        this.codContainer = codContainer;
    }

    public int getTipo() {
        return tipo;
    }

    public void setTipo(int tipo) {
        this.tipo = tipo;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

}
