using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace DocumentManagement.Data.Entities
{
    public class Document : BaseEntity
    {
        public Guid Id { get; set; }
        public Guid CategoryId { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string Url { get; set; }
        public bool IsAddedPageIndxing { get; set; } = false;
        [ForeignKey("CreatedBy")]
        public User User { get; set; }
        [ForeignKey("CategoryId")]
        public Category Category { get; set; }
        public StorageType StorageType { get; set; } 
        public Guid? StorageSettingId { get; set; }
        [ForeignKey("StorageSettingId")]
        public StorageSetting StorageSetting { get; set; }
        public byte[] Key { get; set; }=null;
        public byte[] IV { get; set; }=null;
        public Guid? DocumentStatusId { get; set; }
        [ForeignKey("DocumentStatusId")]
        public DocumentStatus DocumentStatus { get; set; }
        public ICollection<DocumentUserPermission> DocumentUserPermissions { get; set; }
        public ICollection<DocumentRolePermission> DocumentRolePermissions { get; set; }
        public ICollection<DocumentAuditTrail> DocumentAuditTrails { get; set; }
        public ICollection<UserNotification> UserNotifications { get; set; }
        public ICollection<DocumentComment> DocumentComments { get; set; }
        public List<DocumentMetaData> DocumentMetaDatas { get; set; } = new List<DocumentMetaData>();
    }
}
