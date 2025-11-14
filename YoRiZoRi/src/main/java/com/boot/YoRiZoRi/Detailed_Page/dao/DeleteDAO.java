package com.boot.YoRiZoRi.Detailed_Page.dao;

import java.util.HashMap;

public interface DeleteDAO {
	void deleteReview(HashMap<String, String> param);
	void deleteComment(HashMap<String, String> param);
}
