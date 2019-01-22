class ActorVO {
  int actorId;
  String img;
  String name;
  String nameEn;
  String roleName;
  String roleImg;

  ActorVO(this.actorId, this.name,
      {this.img, this.nameEn, this.roleName, this.roleImg});
}
