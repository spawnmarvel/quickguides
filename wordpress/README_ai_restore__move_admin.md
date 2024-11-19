# AI: how to move a wordpress to a new server?

WordPress good to know for admins.
The only things you really want to have a backup for are the wp-content folder and database.



## Moving a WordPress website to a new server is a common task

Moving a WordPress website to a new server is a common task, and it involves transferring both the WordPress files and the database. Here's a detailed guide on how to move a WordPress site to a new server, covering different methods:

**Preparation (Important Steps Before You Start):**

1.  **Backup Everything:** The most crucial step is to create a complete backup of your current WordPress site. This includes all files (themes, plugins, uploads, core files) and the database. Use a plugin like UpdraftPlus, BackupBuddy, Duplicator, or your hosting provider's backup feature.
2.  **Choose Your Method:** Decide whether you'll use a plugin for migration or a manual approach. Plugins are easier, but manual methods offer more control.
3.  **New Hosting Setup:** Set up your new hosting account and ensure it meets WordPress's requirements (PHP, MySQL/MariaDB). You might need to create an empty database on the new server. Note the database name, username, password, and host.
4. **Domain Propagation:** You have two options:
    * **Temporary domain:** Some hosts provide a temporary URL to access your new server before domain propagation is complete. This allows you to test the moved website before making the DNS changes.
    * **Domain Propagation:** Point the domain to the new server by updating the DNS records (usually A records and nameservers) at your domain registrar. Keep in mind that it can take 24-48 hours for DNS propagation to complete.

**Methods for Moving WordPress:**

**1. Using a WordPress Migration Plugin (Recommended for beginners and most users):**

*   **Duplicator:** This plugin is excellent for creating a "package" of your website, including files and the database, which can then be easily uploaded and installed on the new server.
    1.  Install and activate Duplicator on your current WordPress site.
    2.  Go to **Duplicator > Packages** and create a new package.
    3.  Download the installer.php file and the archive.zip file.
    4.  Upload both files to the root directory (public_html or similar) of your new server using FTP or cPanel's File Manager.
    5.  Access the installer by going to `yourdomain.com/installer.php` (replace `yourdomain.com` with your actual domain or temporary domain).
    6.  Follow the installer's prompts, providing the database details for your new server.
    7.  The installer will import the database and set up your WordPress files.
    8.  Update the URLs (if necessary).
    9. Delete the installer files after successful migration.
*   **All-in-One WP Migration:** A simpler plugin that exports your entire site into a single file, which you can then import on the new server.
*   **WP Migrate DB:** Ideal for larger sites, offers advanced options like find and replace of URLs.

**2. Manual Migration (More technical, but offers more control):**

*   **Step 1: Export the Database:**
    1.  Log in to your old hosting account's cPanel or phpMyAdmin.
    2.  Select the WordPress database.
    3.  Go to the **"Export"** tab.
    4.  Choose the **"SQL"** format.
    5.  Select "Custom" and make sure to check "Add DROP TABLE / VIEW / PROCEDURE / FUNCTION"
    6.  Click **"Go"** to download the database backup (.sql file).
*   **Step 2: Copy WordPress Files:**
    1.  Connect to your old server via FTP (FileZilla, Cyberduck, etc.) or use cPanel's File Manager.
    2.  Download all WordPress files from the root directory (usually `public_html` or a subdirectory within it) to your computer.
*   **Step 3: Upload Files to the New Server:**
    1.  Connect to your new server via FTP or cPanel's File Manager.
    2.  Upload all the downloaded WordPress files to the root directory of the new server.
*   **Step 4: Import the Database:**
    1.  Log in to the new hosting account's cPanel or phpMyAdmin.
    2.  Create a new database if you haven't already.
    3.  Select the newly created database.
    4.  Go to the **"Import"** tab.
    5.  Click **"Choose File"** and select the .sql file you exported.
    6.  Click **"Go"** to import the database.
*   **Step 5: Update `wp-config.php`:**
    1.  Edit the `wp-config.php` file on the new server (using FTP or File Manager).
    2.  Update the following lines with the new database credentials:

    ```php
    define( 'DB_NAME', 'new_database_name' );
    define( 'DB_USER', 'new_database_username' );
    define( 'DB_PASSWORD', 'new_database_password' );
    define( 'DB_HOST', 'localhost' ); // or the database host provided by your new host
    ```
*   **Step 6: URL Updates (If the domain name has changed):**
    1. Login to the new WP Admin via the temporary domain or your domain's IP address (if you know it)
    2. Go to **Settings > General** and update the WordPress Address and Site Address with the new domain name.
    Or,
     * If you cannot access wp-admin, using phpMyAdmin, navigate to the `wp_options` table.
        * Find the `siteurl` and `home` rows.
        * Edit these rows and change the `option_value` to the new URL.

**Post-Migration Steps:**

*   **Test the Website:** Thoroughly test all pages, links, and functionalities.
*   **Update Permalinks:** Go to **Settings > Permalinks** and click **"Save Changes"** to regenerate the `.htaccess` file (if you're using pretty permalinks).
*   **Security:** Update all plugins and themes, and review your security settings.
*   **Caching:** Clear any caching plugins and browser cache.
*   **Search and Replace for URLs:** If you used the manual method, you might need to search and replace URLs within the database to fix any broken links or images. You can use a plugin like "Better Search Replace" for this.

By following these steps, you should be able to successfully move your WordPress website to a new server. Remember to always back up your website before making any major changes.