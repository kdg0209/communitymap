package com.kdg.community.app.Common;

import com.kdg.community.app.Domain.Member;

public class AdminAuthCheck {

	public boolean adminAuthChekc(Member member) {
		if(member != null && member.getIsAdmin() == 'Y') {
			return true;
		}else {
			return false;
		}
	}
}
