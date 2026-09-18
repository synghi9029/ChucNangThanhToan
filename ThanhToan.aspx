<%@ Page Title="Thanh toán" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ThanhToan.aspx.cs" Inherits="webbanhang.ThanhToan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .checkout-wrapper { display: flex; gap: 30px; padding: 20px; background: #f9f9f9; }
        .checkout-form { flex: 1.5; background: white; padding: 20px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.05); }
        .checkout-summary { flex: 1; background: #2c3e50; color: white; padding: 20px; border-radius: 8px; height: fit-content; }
        
        .checkout-form h3, .checkout-summary h3 { margin-bottom: 20px; color: #ff7e45; border-bottom: 1px solid #ddd; padding-bottom: 10px; }
        .checkout-summary h3 { border-bottom: 1px solid #555; }
        
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: bold; }
        .form-group input, .form-group select { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        
        .summary-item { display: flex; justify-content: space-between; margin-bottom: 10px; border-bottom: 1px dashed #555; padding-bottom: 5px; }
        .total-price { font-size: 20px; font-weight: bold; color: #ff7e45; text-align: right; margin-top: 15px; }

        .btn-confirm { width: 100%; background: #ff7e45; color: white; border: none; padding: 15px; font-size: 16px; font-weight: bold; border-radius: 5px; cursor: pointer; margin-top: 20px; text-transform: uppercase; }
        .btn-confirm:hover { background: #e66a35; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="checkout-wrapper">
        <!-- Cột nhập thông tin -->
        <div class="checkout-form">
            <h3>Thông tin người đặt sân</h3>
            <div class="form-group">
                <label>Họ và tên</label>
                <asp:TextBox ID="txtHoTen" runat="server" placeholder="Nhập họ tên của bạn" Required="true"></asp:TextBox>
            </div>
            <div class="form-group">
                <label>Số điện thoại</label>
                <asp:TextBox ID="txtSoDienThoai" runat="server" placeholder="Nhập số điện thoại liên hệ" Required="true"></asp:TextBox>
            </div>
            <div class="form-group">
                <label>Ghi chú thêm</label>
                <asp:TextBox ID="txtGhiChu" runat="server" TextMode="MultiLine" Rows="3" placeholder="Yêu cầu thêm (nước suối, thuê bóng...)"></asp:TextBox>
            </div>
            <div class="form-group">
                <label>Phương thức thanh toán</label>
                <asp:DropDownList ID="ddlPhuongThuc" runat="server">
                    <asp:ListItem Value="TienMat" Text="Thanh toán bằng tiền mặt tại sân"></asp:ListItem>
                    <asp:ListItem Value="ChuyenKhoan" Text="Chuyển khoản ngân hàng"></asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>

        <!-- Cột tóm tắt đơn hàng -->
        <div class="checkout-summary">
            <h3>Tóm tắt đơn đặt</h3>
            <div class="summary-item">
                <span>Tên sân:</span>
                <strong><asp:Label ID="lblTenSan" runat="server"></asp:Label></strong>
            </div>
            <div class="summary-item">
                <span>Ngày đá:</span>
                <strong><asp:Label ID="lblNgayDa" runat="server"></asp:Label></strong>
            </div>
            <div class="summary-item">
                <span>Khung giờ:</span>
                <strong><asp:Label ID="lblKhungGio" runat="server"></asp:Label></strong>
            </div>
            
            <div class="total-price">
                Tổng tiền: <asp:Label ID="lblTongTien" runat="server"></asp:Label> VNĐ
            </div>

            <asp:Button ID="btnXacNhan" runat="server" Text="Xác nhận & Thanh toán" CssClass="btn-confirm" OnClick="btnXacNhan_Click" />
            <br />
            <asp:Label ID="lblThongBao" runat="server" ForeColor="Red" style="display:block; margin-top:10px; text-align:center;"></asp:Label>
        </div>
    </div>
</asp:Content>
