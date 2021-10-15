class MobileInfoEntity{
	String? os;
	String? ios_version;
	String? app_version;
	String? net_type;
	String? ip;
	String? interest;
	MobileInfoEntity();

	MobileInfoEntity.fromJson(Map<String, dynamic> json) {
		if (json['os'] != null) {
			this.os = json['os'].toString();
		}
		if (json['ios_version'] != null) {
			this.ios_version = json['ios_version'].toString();
		}
		if (json['app_version'] != null) {
			this.app_version = json['app_version'].toString();
		}
		if (json['net_type'] != null) {
			this.net_type = json['net_type'].toString();
		}
		if (json['ip'] != null) {
			this.ip = json['ip'].toString();
		}
		if (json['interest'] != null) {
			this.interest = json['interest'].toString();
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['os'] = this.os;
		data['ios_version'] = this.ios_version;
		data['app_version'] = this.app_version;
		data['net_type'] = this.net_type;
		data['ip'] = this.ip;
		return data;
	}
}
