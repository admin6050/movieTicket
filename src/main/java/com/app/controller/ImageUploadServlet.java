package com.app.controller;

import com.app.util.DateUtil;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 * 上传图片
 */
public class ImageUploadServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");
        req.setCharacterEncoding("UTF-8");
        FileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        //获取·部署后的项目根路径
        String root =req.getSession().getServletContext().getRealPath("");
        try {
            List<FileItem> list = upload.parseRequest(req);
            for (FileItem fileItem:list){
                //用当前时间做文件名
                String imageName= DateUtil.getCurrentDateStr();
                String newPath = "/upload/" +imageName+"."+fileItem.getName().split("\\.")[1];
                File file = new File(root+newPath);
                fileItem.write(file);//存到硬盘上
                //执行add.jsp的函数setImg
                PrintWriter writer = resp.getWriter();
                writer.println("<script>parent.setImg('"+newPath+"');document.write('上传成功');</script>");
                writer.flush();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
