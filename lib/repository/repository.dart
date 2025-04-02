abstract interface class Repository<T, ID, DTO> {
  findAll();
  findOne(ID key);
  create(DTO dto);
}
