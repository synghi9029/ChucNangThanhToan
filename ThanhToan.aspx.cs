using System;
using System.Data.SqlClient;

namespace webbanhang
{
    public partial class ThanhToan : System.Web.UI.Page
    {
        // Thay bằng chuỗi kết nối thực tế của bạn
        string connectionString = @"Data Source=TEN_MAY_CHU;Initial Catalog=TEN_DATABASE;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadThongTinDonHang();
            }
        }

        private void LoadThongTinDonHang()
        {
            // Giả sử ở trang Đặt sân (Booking.aspx), bạn đã lưu các thông tin này vào Session
            if (Session["SanID"] != null && Session["NgayDa"] != null)
            {
                lblTenSan.Text = Session["TenSan"].ToString();
                lblNgayDa.Text = Session["NgayDa"].ToString();
                lblKhungGio.Text = Session["GioBatDau"].ToString() + " - " + Session["GioKetThuc"].ToString();
                
                // Format tổng tiền
                decimal tongTien = Convert.ToDecimal(Session["TongTien"]);
                lblTongTien.Text = string.Format("{0:N0}", tongTien);
            }
            else
            {
                lblThongBao.Text = "Không tìm thấy thông tin đơn hàng. Vui lòng quay lại trang chọn sân.";
                btnXacNhan.Enabled = false;
            }
        }

        protected void btnXacNhan_Click(object sender, EventArgs e)
        {
            string hoTen = txtHoTen.Text.Trim();
            string sdt = txtSoDienThoai.Text.Trim();
            string ghiChu = txtGhiChu.Text.Trim();
            string phuongThuc = ddlPhuongThuc.SelectedValue;

            if (string.IsNullOrEmpty(hoTen) || string.IsNullOrEmpty(sdt))
            {
                lblThongBao.Text = "Vui lòng nhập đầy đủ Họ tên và Số điện thoại!";
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    // Lệnh SQL thêm vào bảng DonDatSan (Bạn cần điều chỉnh tên bảng/cột cho khớp DB của bạn)
                    string query = @"INSERT INTO DonDatSan (SanID, HoTenKhach, SoDienThoai, NgayDa, GioBatDau, GioKetThuc, TongTien, PhuongThucThanhToan, GhiChu, TrangThaiDon) 
                                     VALUES (@SanID, @HoTen, @SDT, @NgayDa, @GioBatDau, @GioKetThuc, @TongTien, @PhuongThuc, @GhiChu, N'Chờ xác nhận')";
                    
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@SanID", Session["SanID"]);
                        cmd.Parameters.AddWithValue("@HoTen", hoTen);
                        cmd.Parameters.AddWithValue("@SDT", sdt);
                        cmd.Parameters.AddWithValue("@NgayDa", Session["NgayDa"]);
                        cmd.Parameters.AddWithValue("@GioBatDau", Session["GioBatDau"]);
                        cmd.Parameters.AddWithValue("@GioKetThuc", Session["GioKetThuc"]);
                        cmd.Parameters.AddWithValue("@TongTien", Session["TongTien"]);
                        cmd.Parameters.AddWithValue("@PhuongThuc", phuongThuc);
                        cmd.Parameters.AddWithValue("@GhiChu", ghiChu);

                        conn.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            // Đặt hàng thành công, xóa Session hiện tại
                            Session.Remove("SanID");
                            Session.Remove("NgayDa");
                            // ...

                            // Có thể chuyển hướng sang trang Cảm ơn / Thông báo thành công
                            Response.Redirect("Success.aspx"); 
                        }
                        else
                        {
                            lblThongBao.Text = "Có lỗi xảy ra, vui lòng thử lại sau.";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblThongBao.Text = "Lỗi hệ thống: " + ex.Message;
            }
        }
    }
}
