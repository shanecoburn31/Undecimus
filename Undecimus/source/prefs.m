//
//  prefs.c
//  Undecimus
//
//  Created by Pwn20wnd on 5/3/19.
//  Copyright © 2019 Pwn20wnd. All rights reserved.
//

#include "prefs.h"
#include <Foundation/Foundation.h>
#include <common.h>
#include "utils.h"

@interface NSUserDefaults ()
- (id)objectForKey:(id)arg1 inDomain:(id)arg2;
- (void)setObject:(id)arg1 forKey:(id)arg2 inDomain:(id)arg3;
@end

static NSUserDefaults *userDefaults = nil;
static NSString *prefsFile = nil;

bool load_prefs(prefs_t *prefs) {
    if (prefs == NULL) {
        return false;
    }
    prefs->load_tweaks = (bool)[[userDefaults objectForKey:K_TWEAK_INJECTION inDomain:prefsFile] boolValue];
    prefs->load_daemons = (bool)[[userDefaults objectForKey:K_LOAD_DAEMONS inDomain:prefsFile] boolValue];
    prefs->dump_apticket = (bool)[[userDefaults objectForKey:K_DUMP_APTICKET inDomain:prefsFile] boolValue];
    prefs->run_uicache = (bool)[[userDefaults objectForKey:K_REFRESH_ICON_CACHE inDomain:prefsFile] boolValue];
    prefs->boot_nonce = (const char *)[[userDefaults objectForKey:K_BOOT_NONCE inDomain:prefsFile] UTF8String];
    prefs->disable_auto_updates = (bool)[[userDefaults objectForKey:K_DISABLE_AUTO_UPDATES inDomain:prefsFile] boolValue];
    prefs->disable_app_revokes = (bool)[[userDefaults objectForKey:K_DISABLE_APP_REVOKES inDomain:prefsFile] boolValue];
    prefs->overwrite_boot_nonce = (bool)[[userDefaults objectForKey:K_OVERWRITE_BOOT_NONCE inDomain:prefsFile] boolValue];
    prefs->export_kernel_task_port = (bool)[[userDefaults objectForKey:K_EXPORT_KERNEL_TASK_PORT inDomain:prefsFile] boolValue];
    prefs->restore_rootfs = (bool)[[userDefaults objectForKey:K_RESTORE_ROOTFS inDomain:prefsFile] boolValue];
    prefs->increase_memory_limit = (bool)[[userDefaults objectForKey:K_INCREASE_MEMORY_LIMIT inDomain:prefsFile] boolValue];
    prefs->ecid = (const char *)[[userDefaults objectForKey:K_ECID inDomain:prefsFile] UTF8String];
    prefs->install_cydia = (bool)[[userDefaults objectForKey:K_INSTALL_CYDIA inDomain:prefsFile] boolValue];
    prefs->install_openssh = (bool)[[userDefaults objectForKey:K_INSTALL_OPENSSH inDomain:prefsFile] boolValue];
    prefs->reload_system_daemons = (bool)[[userDefaults objectForKey:K_RELOAD_SYSTEM_DAEMONS inDomain:prefsFile] boolValue];
    prefs->reset_cydia_cache = (bool)[[userDefaults objectForKey:K_RESET_CYDIA_CACHE inDomain:prefsFile] boolValue];
    prefs->ssh_only = (bool)[[userDefaults objectForKey:K_SSH_ONLY inDomain:prefsFile] boolValue];
    prefs->enable_get_task_allow = (bool)[[userDefaults objectForKey:K_ENABLE_GET_TASK_ALLOW inDomain:prefsFile]boolValue];
    prefs->set_cs_debugged = (bool)[[userDefaults objectForKey:K_SET_CS_DEBUGGED inDomain:prefsFile] boolValue];
    prefs->exploit = (int)[[userDefaults objectForKey:K_EXPLOIT inDomain:prefsFile] intValue];
    prefs->hide_log_window = (bool)[[userDefaults objectForKey:K_HIDE_LOG_WINDOW inDomain:prefsFile] boolValue];
    return true;
}

bool set_prefs(prefs_t *prefs) {
    if (prefs == NULL) {
        return false;
    }
    [userDefaults setObject:[NSNumber numberWithBool:(BOOL)prefs->load_tweaks] forKey:K_TWEAK_INJECTION inDomain:prefsFile];
    [userDefaults setObject:[NSNumber numberWithBool:(BOOL)prefs->load_daemons] forKey:K_LOAD_DAEMONS inDomain:prefsFile];
    [userDefaults setObject:[NSNumber numberWithBool:(BOOL)prefs->dump_apticket] forKey:K_DUMP_APTICKET inDomain:prefsFile];
    [userDefaults setObject:[NSNumber numberWithBool:(BOOL)prefs->run_uicache] forKey:K_REFRESH_ICON_CACHE inDomain:prefsFile];
    [userDefaults setObject:[NSString stringWithUTF8String:(const char *)prefs->boot_nonce] forKey:K_BOOT_NONCE inDomain:prefsFile];
    [userDefaults setObject:[NSNumber numberWithBool:(BOOL)prefs->disable_auto_updates] forKey:K_DISABLE_AUTO_UPDATES inDomain:prefsFile];
    [userDefaults setObject:[NSNumber numberWithBool:(BOOL)prefs->disable_app_revokes] forKey:K_DISABLE_APP_REVOKES inDomain:prefsFile];
    [userDefaults setObject:[NSNumber numberWithBool:(BOOL)prefs->overwrite_boot_nonce] forKey:K_OVERWRITE_BOOT_NONCE inDomain:prefsFile];
    [userDefaults setObject:[NSNumber numberWithBool:(BOOL)prefs->export_kernel_task_port] forKey:K_EXPORT_KERNEL_TASK_PORT inDomain:prefsFile];
    [userDefaults setObject:[NSNumber numberWithBool:(BOOL)prefs->restore_rootfs] forKey:K_RESTORE_ROOTFS inDomain:prefsFile];
    [userDefaults setObject:[NSNumber numberWithBool:(BOOL)prefs->increase_memory_limit] forKey:K_INCREASE_MEMORY_LIMIT inDomain:prefsFile];
    [userDefaults setObject:[NSString stringWithUTF8String:(const char *)prefs->ecid] forKey:K_ECID inDomain:prefsFile];
    [userDefaults setObject:[NSNumber numberWithBool:(BOOL)prefs->install_cydia] forKey:K_INSTALL_CYDIA inDomain:prefsFile];
    [userDefaults setObject:[NSNumber numberWithBool:(BOOL)prefs->install_openssh] forKey:K_INSTALL_OPENSSH inDomain:prefsFile];
    [userDefaults setObject:[NSNumber numberWithBool:(BOOL)prefs->reload_system_daemons] forKey:K_RELOAD_SYSTEM_DAEMONS inDomain:prefsFile];
    [userDefaults setObject:[NSNumber numberWithBool:(BOOL)prefs->reset_cydia_cache] forKey:K_RESET_CYDIA_CACHE inDomain:prefsFile];
    [userDefaults setObject:[NSNumber numberWithBool:(BOOL)prefs->ssh_only] forKey:K_SSH_ONLY inDomain:prefsFile];
    [userDefaults setObject:[NSNumber numberWithBool:(BOOL)prefs->enable_get_task_allow] forKey:K_ENABLE_GET_TASK_ALLOW inDomain:prefsFile];
    [userDefaults setObject:[NSNumber numberWithBool:(BOOL)prefs->set_cs_debugged] forKey:K_SET_CS_DEBUGGED inDomain:prefsFile];
    [userDefaults setObject:[NSNumber numberWithInt:(int)prefs->exploit] forKey:K_EXPLOIT inDomain:prefsFile];
    [userDefaults setObject:[NSNumber numberWithBool:(BOOL)prefs->hide_log_window] forKey:K_HIDE_LOG_WINDOW inDomain:prefsFile];
    [userDefaults synchronize];
    return true;
}

void register_default_prefs() {
    NSMutableDictionary *defaults = [NSMutableDictionary new];
    defaults[K_TWEAK_INJECTION] = @YES;
    defaults[K_LOAD_DAEMONS] = @YES;
    defaults[K_DUMP_APTICKET] = @YES;
    defaults[K_REFRESH_ICON_CACHE] = @NO;
    defaults[K_BOOT_NONCE] = @"0x1111111111111111";
    defaults[K_DISABLE_AUTO_UPDATES] = @YES;
    defaults[K_DISABLE_APP_REVOKES] = @YES;
    defaults[K_OVERWRITE_BOOT_NONCE] = @YES;
    defaults[K_EXPORT_KERNEL_TASK_PORT] = @NO;
    defaults[K_RESTORE_ROOTFS] = @NO;
    defaults[K_INCREASE_MEMORY_LIMIT] = @NO;
    defaults[K_ECID] = @"0x0";
    defaults[K_INSTALL_CYDIA] = @NO;
    defaults[K_INSTALL_OPENSSH] = @NO;
    defaults[K_RELOAD_SYSTEM_DAEMONS] = @YES;
    defaults[K_SSH_ONLY] = @NO;
    defaults[K_ENABLE_GET_TASK_ALLOW] = @NO;
    defaults[K_SET_CS_DEBUGGED] = @NO;
    defaults[K_HIDE_LOG_WINDOW] = @NO;
    defaults[K_EXPLOIT] = [NSNumber numberWithInteger:recommendedJailbreakSupport()];
    [userDefaults registerDefaults:defaults];
}

void reset_prefs() {
    [userDefaults removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]];
}
__attribute__((constructor))
static void ctor() {
    userDefaults = [NSUserDefaults standardUserDefaults];
    prefsFile = [NSString stringWithFormat:@"%@/Library/Preferences/%@.plist", NSHomeDirectory(), [[NSBundle mainBundle] bundleIdentifier]];
}
