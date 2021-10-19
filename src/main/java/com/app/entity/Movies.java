package com.app.entity;


import java.security.Timestamp;
import java.util.Date;

public class Movies {
    private int id;
    private String movieName;
    private String director;
    private String time;
    private String language;
    private String publishDate;
    private double boxOffice;
    private double ticketPrice;
    private String session;
    private String videoHall;
    private String imgpath;
    private String description;
    private int hot;
    private String iszsqd;
    private String ishprc;
    private String isjrpf;
    private Date updatedate;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getMovieName() {
        return movieName;
    }

    public void setMovieName(String movieName) {
        this.movieName = movieName;
    }

    public String getDirector() {
        return director;
    }

    public void setDirector(String director) {
        this.director = director;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public String getPublishDate() {
        return publishDate;
    }

    public void setPublishDate(String publishDate) {
        this.publishDate = publishDate;
    }

    public double getBoxOffice() {
        return boxOffice;
    }

    public void setBoxOffice(double boxOffice) {
        this.boxOffice = boxOffice;
    }

    public double getTicketPrice() {
        return ticketPrice;
    }

    public void setTicketPrice(double ticketPrice) {
        this.ticketPrice = ticketPrice;
    }

    public String getSession() {
        return session;
    }

    public void setSession(String session) {
        this.session = session;
    }

    public String getVideoHall() {
        return videoHall;
    }

    public void setVideoHall(String videoHall) {
        this.videoHall = videoHall;
    }

    public String getImgpath() {
        return imgpath;
    }

    public void setImgpath(String imgpath) {
        this.imgpath = imgpath;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getHot() {
        return hot;
    }

    public void setHot(int hot) {
        this.hot = hot;
    }

    public String getIszsqd() {
        return iszsqd;
    }

    public void setIszsqd(String iszsqd) {
        this.iszsqd = iszsqd;
    }

    public String getIshprc() {
        return ishprc;
    }

    public void setIshprc(String ishprc) {
        this.ishprc = ishprc;
    }

    public String getIsjrpf() {
        return isjrpf;
    }

    public void setIsjrpf(String isjrpf) {
        this.isjrpf = isjrpf;
    }

    public Date getUpdatedate() {
        return updatedate;
    }

    public void setUpdatedate(Date updatedate) {
        this.updatedate = updatedate;
    }
}
