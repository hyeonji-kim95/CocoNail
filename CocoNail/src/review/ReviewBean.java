package review;

import java.sql.Date;
import java.sql.Timestamp;

public class ReviewBean {
	private int review_num;
	private String member_id;
	private String review_subject;
	private String review_content;
	private String review_file;
	private int re_ref;
	private int re_lev;
	private int re_seq;
	private Timestamp review_date;
	private int review_readcount;
	private int review_re;
	private String review_reContent;
	
	
	public int getReview_num() {
		return review_num;
	}
	public void setReview_num(int review_num) {
		this.review_num = review_num;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getReview_subject() {
		return review_subject;
	}
	public void setReview_subject(String review_subject) {
		this.review_subject = review_subject;
	}
	public String getReview_content() {
		return review_content;
	}
	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}
	public String getReview_file() {
		return review_file;
	}
	public void setReview_file(String review_file) {
		this.review_file = review_file;
	}
	public int getRe_ref() {
		return re_ref;
	}
	public void setRe_ref(int re_ref) {
		this.re_ref = re_ref;
	}
	public int getRe_lev() {
		return re_lev;
	}
	public void setRe_lev(int re_lev) {
		this.re_lev = re_lev;
	}
	public int getRe_seq() {
		return re_seq;
	}
	public void setRe_seq(int re_seq) {
		this.re_seq = re_seq;
	}
	public Timestamp getReview_date() {
		return review_date;
	}
	public void setReview_date(Timestamp review_date) {
		this.review_date = review_date;
	}
	public int getReview_readcount() {
		return review_readcount;
	}
	public void setReview_readcount(int review_readcount) {
		this.review_readcount = review_readcount;
	}
	public int getReview_re() {
		return review_re;
	}
	public void setReview_re(int review_re) {
		this.review_re = review_re;
	}
	public String getReview_reContent() {
		return review_reContent;
	}
	public void setReview_reContent(String review_reContent) {
		this.review_reContent = review_reContent;
	}

	
}
