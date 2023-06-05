class JEmail {
    String cEmail;

    JEmail({
        required this.cEmail,
    });

    factory JEmail.fromJson(Map<String, dynamic> json) => JEmail(
        cEmail: json["c_Email"],
    );

    Map<String, dynamic> toJson() => {
        "c_Email": cEmail,
    };
}

class JMobile {
    int nMobile;

    JMobile({
        required this.nMobile,
    });

    factory JMobile.fromJson(Map<String, dynamic> json) => JMobile(
        nMobile: json["n_Mobile"],
    );

    Map<String, dynamic> toJson() => {
        "n_Mobile": nMobile,
    };
}
