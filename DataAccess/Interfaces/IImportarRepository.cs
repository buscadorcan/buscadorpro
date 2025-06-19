namespace DataAccess.Interfaces
{
    public interface IImportarRepository
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="homologacionIds"></param>
        /// <param name="selectFields"></param>
        /// <param name="viewName"></param>
        /// <returns></returns>
        string buildSelectViewQuery(int[] homologacionIds, string[] selectFields, string viewName);

        /// <summary>
        /// 
        /// </summary>
        /// <param name="selectQuery"></param>
        /// <returns></returns>
        bool executeQueryView(string selectQuery);
    }
}
